import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, String>? _localizedStrings;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Future<bool> load() async {
    try {
      String jsonString = await rootBundle.loadString(
        'assets/languages/${locale.languageCode}.json',
      );
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      _localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });

      return true;
    } catch (e) {
      debugPrint('Error loading localization: $e');
      return false;
    }
  }

  String translate(String key) {
    return _localizedStrings?[key] ?? key;
  }

  String translateWithFallback(String key, String fallback) {
    final value = _localizedStrings?[key];
    return value == null || value.isEmpty ? fallback : value;
  }

  // Common getters
  String get failedToFetchDetails => translate('failedToFetchDetails');
  String get appguide => translate('app_guide');
  String get applyForNewEventPermissionDesc =>
      translate('applyForNewEventPermissionDesc');
  String get noData => translate('noData');
  String get noInfo => translate('noInfo');
  String get tryDifferentKeywords => translate('tryDifferentKeywords');
  String get goToDashboard => translate('goToDashboard');
  String get selectLanguage => translate('selectLanguage');
  String get welcomeCitizen => translate('welcomeCitizen');
  String get select => translate('select');
  String get getStarted => translate('getStarted');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['mr', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
