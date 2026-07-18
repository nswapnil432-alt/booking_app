// import 'package:flutter/foundation.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// void setupCrashlytics() {
//   // Only enable in RELEASE mode and not on web
//   if (kReleaseMode && !kIsWeb) {
//     FlutterError.onError =
//         FirebaseCrashlytics.instance.recordFlutterFatalError;

//     PlatformDispatcher.instance.onError = (error, stack) {
//       FirebaseCrashlytics.instance
//           .recordError(error, stack, fatal: true);
//       return true;
//     };
//   }
// }