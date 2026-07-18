
// import 'dart:io';

// import '../dependency_locator.dart';
// import '../misc/logger_service.dart';
// import '../networks/end_point.dart';
// import '../networks/network_service.dart';

// class VersionCheckService {
//   final NetworkService _networkService = getIt<NetworkService>();
  
//   // App name to filter from the response. 
//   // static const String _appName = 'government-online'; 

//   static const String _appName = 'janhit'; 
//   Future<VersionCheckResult?> checkVersion() async {
//     try {
//       // Use NetworkService for the request
//       final response = await _networkService.getRequest(
//         EndPoint.appVersionUrl,
//       );

//       if (response != null && response is Map<String, dynamic>) {
//         if (response['success'] == true && response['data'] is List) {
//           final apps = response['data'] as List;
          
//           // Find our app
//           final appData = apps.firstWhere(
//             (app) => (app['app_name'] as String).toLowerCase() == _appName.toLowerCase() && 
//                      (app['platform'] as String).toLowerCase() == (Platform.isAndroid ? 'android' : 'ios'),
//             orElse: () => null,
//           );

//           if (appData != null) {
//             final String latestVersion = appData['latest_version'];
//             final String minSupportedVersion = appData['min_supported_version'];
//             final String storeUrl = appData['storeUrl'];
//             final String currentVersion = EndPoint.currentAppVersion;

//             bool updateAvailable = _isVersionGreaterThan(latestVersion, currentVersion);
//             bool forceUpdate = _isVersionGreaterThan(minSupportedVersion, currentVersion);

//             if (updateAvailable) {
//               return VersionCheckResult(
//                 updateAvailable: true,
//                 forceUpdate: forceUpdate,
//                 storeUrl: storeUrl,
//                 latestVersion: latestVersion,
//                 currentVersion: currentVersion,
//               );
//             }
//           }
//         }
//       }
//     } catch (e) {
//       LoggerService.log('Version check failed: $e');
//     }
//     return null;
//   }

//   bool _isVersionGreaterThan(String newVersion, String currentVersion) {
//     List<String> v1 = newVersion.split('.');
//     List<String> v2 = currentVersion.split('.');

//     // Pad with zeros if lengths differ
//     while (v1.length < 3) {
//       v1.add('0');
//     }
//     while (v2.length < 3) {
//       v2.add('0');
//     }

//     for (int i = 0; i < 3; i++) {
//         int ver1 = int.tryParse(v1[i]) ?? 0;
//         int ver2 = int.tryParse(v2[i]) ?? 0;
//         if (ver1 > ver2) return true;
//         if (ver1 < ver2) return false;
//     }
//     return false;
//   }
// }

// class VersionCheckResult {
//   final bool updateAvailable;
//   final bool forceUpdate;
//   final String storeUrl;
//   final String latestVersion;
//   final String currentVersion;

//   VersionCheckResult({
//     required this.updateAvailable,
//     required this.forceUpdate,
//     required this.storeUrl,
//     required this.latestVersion,
//     required this.currentVersion,
//   });
// }
