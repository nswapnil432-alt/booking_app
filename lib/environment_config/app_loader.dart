import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../utils/localiization/localization_manager.dart';
import '../utils/localiization/app_localizations.dart';
import '../utils/constants/app_colors.dart';
import '../utils/navigation/route_manager.dart';
import 'environment_config.dart';
import '../utils/services/network_connectivity_service.dart';

@pragma('vm:entry-point')




class AppLoader {
  void loadApp(String path) async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotEnv.load(fileName: path);
    await _preInit();
    runApp(const MyApp());
  }
}

Future<void> _preInit() async {
  try {
    await GetStorage.init();
    await GetStorage.init('poll_votes');
    // await initializeDateFormatting();
    // Initialize localization
    final localizationManager = LocalizationManager();
    await localizationManager.initialize();
    // Set system UI overlay style to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarDividerColor: AppColors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    ]);

    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);   
    //     setupCrashlytics();
    // FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
    // initDependencyLocator();
    // final savedClientId = GetStorage().read(LocalStorageKeyStrings.clientId);
    // if (savedClientId != null) {
    //   EndPoint.clientId = savedClientId.toString();
    // }
    // await getIt.allReady();
  // ignore: empty_catches
  } catch (e) {
  }
}

// for remove scroll indicator
class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}

class RootController extends GetxController {
  static const String uiKey = "root_refresh";
  Key rootKey = UniqueKey();

  void restartApp() {
    // Delay slightly to ensure navigation or other async tasks finish
    Future.delayed(const Duration(milliseconds: 50), () {
      // Clear all controllers (non-permanent ones)
      Get.deleteAll(force: false);
      
      // Change root key to force full widget tree rebuild
      rootKey = UniqueKey();
      update([uiKey]);
    });
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NetworkConnectivityService _networkService = NetworkConnectivityService();
  // final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    // Initialize RootController as permanent so it survives group switching cleanup
    Get.put(RootController(), permanent: true);
    // Get.put(PermissionService(), permanent: true);
    
    // Initialize network service
    _networkService.initialize(context);
    _initializePermissions();
    // _notificationService.createNotificationChannel();
    // _notificationService.firebaseInit(context);
    // _notificationService.setupInteractMessage(context);
    // _notificationService.getDeviceToken();

    // Initialize Deep Linking
    // DeepLinkService().initialize();
    
    // Listen to locale changes
    LocalizationManager().addListener(_onLocaleChanged);
  }

  Future<void> _initializePermissions() async {
    // checkPermission();
    // 1. Ask notification permission first
    // await _notificationService.requestNotificationPermission();
    
    // 2. Small delay to ensure OS handles the first dialog dismiss
    await Future.delayed(const Duration(milliseconds: 500));
    
    // 3. Ask location permission
    
  }


  // void checkPermission() async{
  //     final locationService = LocationService.instance;
  //       if (!locationService.hasValidLocation) {
  //         await locationService.requestLocationPermission();
  //       } else {
  //         await locationService.refreshLocation();
  //       }
  // }
  void _onLocaleChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    LocalizationManager().removeListener(_onLocaleChanged);
    _networkService.dispose();
    // DeepLinkService().dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(
      id: RootController.uiKey,
      builder: (rootCtrl) {
        return MaterialApp.router(
          key: rootCtrl.rootKey,
          debugShowCheckedModeBanner: false,
          // Add localization support
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
      supportedLocales: LocalizationManager.supportedLocales,
      locale: LocalizationManager().currentLocale,
      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: AppColors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
           child: MediaQuery(
    data: MediaQuery.of(context).copyWith(
      textScaler: const TextScaler.linear(1.0),
    ),
    child: child ?? const SizedBox.shrink(),
  ),

        );
      },
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.transparent),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.blue,
        ),
        useMaterial3: true,
        fontFamily: 'Figtree',
        splashColor: AppColors.transparent,
        highlightColor: AppColors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(elevation: 8.0),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.buttonBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(26.0),
            ),
          ),
        ),
        // scaffoldBackgroundColor: Color(0xFF3F4F6), // Fully transparent scaffold background
      ),
      routerDelegate: AppRouter.router.routerDelegate,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
    );
      }
    );
  }

  // void subscribe() {
  //   _notificationService.messaging.subscribeToTopic('Admin');
  // }
  
}

// Property to track if custom sound is playing
bool isCustomSoundPlaying = false;






// Helper to get asset file path (useful for background isolates)
// Future<String> _getAssetFilePath(String assetPath) async {
//   // final tempDir = await getTemporaryDirectory();
//   final fileName = assetPath.split('/').last;
//   // final file = File('${tempDir.path}/$fileName');
  
//   // if (!file.existsSync()) {
//   //   final byteData = await rootBundle.load(assetPath);
//   //   final bytes = byteData.buffer.asUint8List();
//   //   await file.writeAsBytes(bytes, flush: true);
//   //   LoggerService.log("Asset copied to: ${file.path}");
//   // }
//   // return file.path;
// }

// Future<void> playCustomSound({required String assetPath}) async {
//   if (isCustomSoundPlaying) return;
  
//   // 1. Clear any existing signal file
//   try {
//     final file = _getSignalFile();
//     if (file.existsSync()) {
//       file.deleteSync();
//       LoggerService.log("Existing signal file cleared");
//     }
//   } catch (e) {
//     LoggerService.log("Error clearing signal file: $e");
//   }
  
//   isCustomSoundPlaying = true;
//   _initLifecycleListener();

//   try {
//     final session = await AudioSession.instance;
//     await session.configure(
//       const AudioSessionConfiguration(
//         avAudioSessionCategory: AVAudioSessionCategory.playback,
//         avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
//         avAudioSessionMode: AVAudioSessionMode.defaultMode,
//         avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
//         androidAudioAttributes: AndroidAudioAttributes(
//           contentType: AndroidAudioContentType.sonification,
//           usage: AndroidAudioUsage.notificationRingtone,
//         ),
//         androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
//         androidWillPauseWhenDucked: false,
//       ),
//     );

//     await session.setActive(true); 

//     if (await Vibration.hasVibrator() ?? false) {
//       Vibration.vibrate(pattern: [500, 1000], repeat: 0);
//     }

//     await _audioPlayer.stop();
//     await _audioPlayer.setVolume(1.0);
    
//     // CRITICAL FIX: Do NOT use LoopMode.one (infinite native loop).
//     // Use LoopMode.off and loop manually in Dart.
//     // unlikely scenario: If Dart isolate is suspended, audio stops after 1 plays.
//     // likely scenario: Dart stays alive, we check signal before re-playing.
//     await _audioPlayer.setLoopMode(LoopMode.off);
    
//     // Background Isolate Fix: Copy asset to file to avoid ExoPlayer asset proxy issues
//     final path = await _getAssetFilePath(assetPath);
//     await _audioPlayer.setFilePath(path);
//     await _audioPlayer.play();

//     // Listen for completion to loop manually
//     _audioPlayer.playerStateStream.listen((state) async {
//         if (state.processingState == ProcessingState.completed) {
//             // Check for stop signal before looping
//             bool shouldStop = false;
//             try {
//                 final file = _getSignalFile();
//                 if (file.existsSync()) {
//                     LoggerService.log("Background player found signal file at loop end - Stopping!");
//                     shouldStop = true;
//                     try { file.deleteSync(); } catch (_) {}
//                 }
//             } catch (e) {
//                 LoggerService.log("Error checking signal: $e");
//             }

//             if (!shouldStop && isCustomSoundPlaying) {
//                  LoggerService.log("Looping sound manually...");
//                  await _audioPlayer.seek(Duration.zero);
//                  await _audioPlayer.play();
//             } else {
//                 stopCustomSound();
//             }
//         }
//     });

//     // Keep the periodic check as a backup (in case the file is long)
//     _soundTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
//       if (!isCustomSoundPlaying) {
//           timer.cancel();
//           return;
//       }
//       try {
//         final file = _getSignalFile();
//         if (file.existsSync()) {
//             LoggerService.log("Background player found signal file (Timer) - Stopping!");
//             timer.cancel();
//             stopCustomSound();
//              try { file.deleteSync(); } catch (_) {}
//         }
//       } catch (e) {
//          // ignore
//       }
//     });
    
//     // Auto-stop after 30 seconds
//     Future.delayed(const Duration(seconds: 30), () {
//         if (isCustomSoundPlaying) stopCustomSound();
//     });
    
//   } catch (e) {
//     LoggerService.log("Sound error: $e");
//     isCustomSoundPlaying = false;
//     Vibration.cancel();
//   }
// }

// Stop the custom sound
// void stopCustomSound() {
//   _audioPlayer.stop();
//   Vibration.cancel();
//   if (isCustomSoundPlaying) {
//     _soundTimer?.cancel();
//     _soundTimer = null;
//     isCustomSoundPlaying = false;
//     LoggerService.log("Custom sound stopped");
//   }
// }


