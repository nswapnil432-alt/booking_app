class AnalyticsConstants {
  // Event Names
  static const String screenView = 'screen_view';
  static const String loginSuccess = 'login_success';
  static const String loginFailed = 'login_failed';
  static const String signupSuccess = 'signup_success';
  static const String logout = 'logout';
  static const String featureUsed = 'feature_used';
  static const String apiRequest = 'api_request';
  static const String tabClick = 'tab_click';

  // Feature Names (for 'feature_used' event parameter)
  static const String featureSuggestionBox = 'suggestion_box';
  static const String featureReportIssue = 'report_issue';
  static const String featureEmergencyService = 'emergency_service';
  static const String featureProjectDetails = 'project_details';
  static const String featureVisitorRequest = 'visitor_request';
  static const String featureSchemaDetails = 'schema_details';

  // Parameter Names
  static const String paramFeatureName = 'feature_name';
  static const String paramScreenName = 'screen_name';
  static const String paramScreenClass = 'screen_class';
  static const String paramEndpoint = 'endpoint';
  static const String paramStatus = 'status';
  static const String paramUserId = 'user_id';
  static const String paramErrorMessage = 'error_message';
  static const String paramTabName = 'tab_name';

  // Specific Tab Names
  static const String tabHome = 'home_tab';
  static const String tabComplaints = 'complaints_tab';
  static const String tabProject = 'project_tab';
  static const String tabServices = 'services_tab';
  static const String tabSuggestion = 'suggestion_tab';
  static const String tabVisitor = 'visitor_tab';
}
