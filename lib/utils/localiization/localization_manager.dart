import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
 
class LocalizationManager extends ChangeNotifier {
  static final LocalizationManager _instance = LocalizationManager._internal();
  factory LocalizationManager() => _instance;
  LocalizationManager._internal();
 
  static const String _languageKey = 'selected_language';
  static const String _countryKey = 'selected_country';
 
  final GetStorage _storage = GetStorage();
 
  static const List<Locale> supportedLocales = [
    Locale('mr', 'IN'),
    Locale('en', 'US'),
  ];
 
  static const Locale defaultLocale = Locale('mr', 'IN');
 
  Locale _currentLocale = defaultLocale;
  Locale get currentLocale => _currentLocale;
 
  Future<void> initialize() async {
    try {
      await GetStorage.init();  
     
      final savedLanguage = _storage.read(_languageKey);
      // final savedCountry = _storage.read(_countryKey);
     
      if (savedLanguage != null) {
        final matchingLocale = supportedLocales.firstWhere(
          (locale) => locale.languageCode == savedLanguage,
          orElse: () => defaultLocale,
        );
        _currentLocale = matchingLocale;
      } else {
        _currentLocale = defaultLocale;
      }
    } catch (e) {
      debugPrint('Error initializing LocalizationManager: $e');
      _currentLocale = defaultLocale;
    }
  }
 
  Future<void> changeLocale(Locale locale) async {
    try {
      if (isLocaleSupported(locale)) {
        _currentLocale = locale;
        await _storage.write(_languageKey, locale.languageCode);
        if (locale.countryCode != null) {
          await _storage.write(_countryKey, locale.countryCode);
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error changing locale: $e');
    }
  }
 
  Locale? getLocaleByLanguageCode(String languageCode) {
    try {
      return supportedLocales.firstWhere(
        (locale) => locale.languageCode == languageCode,
      );
    } catch (e) {
      return null;
    }
  }
 
  bool isLocaleSupported(Locale locale) {
    return supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }
 
  String getCurrentLanguageName() {
    switch (_currentLocale.languageCode) {
      case 'mr':
        return 'मराठी';
      case 'en':
        return 'English';
      default:
        return 'English';
    }
  }
 
  List<Map<String, String>> getAvailableLanguages() {
    return [
      {'code': 'mr', 'name': 'Marathi', 'nativeName': 'मराठी'},
      {'code': 'en', 'name': 'English', 'nativeName': 'English'},
    ];
  }
 
  List<String> getSupportedLanguageCodes() {
    return supportedLocales.map((locale) => locale.languageCode).toList();
  }
}