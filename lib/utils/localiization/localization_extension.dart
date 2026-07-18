import 'package:flutter/material.dart';

import 'app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations? get _l10n => AppLocalizations.of(this);

  // Quick access to common translations with null safety
  String translateSafe(String key, {required String fallback}) {
    return _l10n?.translateWithFallback(key, fallback) ?? fallback;
  }

  String get failedToFetchDetailsSafe =>
      translateSafe('failedToFetchDetails', fallback: 'Failed to fetch details');

  String get applyForNewEventPermissionDescSafe => translateSafe(
        'applyForNewEventPermissionDesc',
        fallback: 'Apply for new event permission',
      );

  String get noDataSafe => translateSafe('noData', fallback: 'No Data Found');

  String get noInfoSafe =>
      translateSafe('noInfo', fallback: 'No information available');

  String get tryDifferentKeywordsSafe => translateSafe(
        'tryDifferentKeywords',
        fallback: 'Try different keywords',
      );

  String get goToDashboardSafe =>
      translateSafe('goToDashboard', fallback: 'Go To Dashboard');

  String get selectlanguageSafe =>
      translateSafe('selectLanguage', fallback: 'Select Language');

  String get welcomeCitizenSafe =>
      translateSafe('welcomeCitizen', fallback: 'Welcome, Citizen');

  String get selectSafe =>
      translateSafe('select', fallback: 'Select your preferred language');

  String get getstartedSafe =>
      translateSafe('getStarted', fallback: 'Get Started');

  String? get failedToFetchDetails => _l10n?.failedToFetchDetails;
  String? get applyForNewEventPermissionDesc =>
      _l10n?.applyForNewEventPermissionDesc;
}
