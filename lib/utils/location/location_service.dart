// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart' as ph;
// import '../networks/toast_services/toast_services.dart';

// class LocationService extends GetxController {
//   static LocationService get instance => Get.find<LocationService>();

//   // Location state
//   final RxDouble _lat = 0.0.obs;
//   final RxDouble _long = 0.0.obs;
//   final RxBool _isLocationPermissionGranted = false.obs;
//   final RxBool _isRequestingLocation = false.obs;
//   final RxBool _isLocationServiceEnabled = false.obs;
//   final Rx<DateTime?> _lastFetchTime = Rx<DateTime?>(null);

//   // Getters
//   double get lat => _lat.value;
//   double get long => _long.value;
//   bool get isLocationPermissionGranted => _isLocationPermissionGranted.value;
//   bool get isRequestingLocation => _isRequestingLocation.value;
//   bool get isLocationServiceEnabled => _isLocationServiceEnabled.value;
//   bool get hasValidLocation => _lat.value != 0.0 && _long.value != 0.0;
//   bool get isReady =>
//       isLocationPermissionGranted && hasValidLocation && isLocationServiceEnabled;

//   StreamSubscription<ServiceStatus>? _serviceStatusSubscription;

//   @override
//   void onInit() {
//     super.onInit();
//     _initService();
//   }

//   @override
//   void onClose() {
//     _serviceStatusSubscription?.cancel();
//     super.onClose();
//   }

//   Future<void> _initService() async {
//     await _checkLocationServiceStatus();
//     // Listen to location service status changes
//     _serviceStatusSubscription = Geolocator.getServiceStatusStream().listen((status) {
//       _isLocationServiceEnabled.value = status == ServiceStatus.enabled;
//       if (status == ServiceStatus.enabled) {
//         refreshLocation();
//       }
//     });
//   }

//   /// Check if location services are enabled
//   Future<bool> _checkLocationServiceStatus() async {
//     bool enabled = await Geolocator.isLocationServiceEnabled();
//     _isLocationServiceEnabled.value = enabled;
//     return enabled;
//   }

//   /// Request location permission with proper handling
//   /// Returns true if permission is granted and location is obtained
//   Future<bool> requestLocationPermission() async {
//     // Prevent multiple simultaneous requests
//     if (_isRequestingLocation.value) return false;

//     try {
//       _isRequestingLocation.value = true;
//       update();

//       // 1. Check if location services (GPS) are enabled
//       bool serviceEnabled = await _checkLocationServiceStatus();
//       if (!serviceEnabled) {
//         _showLocationServiceDialog();
//         return false;
//       }

//       // 2. Check current permission status
//       LocationPermission permission = await Geolocator.checkPermission();

//       if (permission == LocationPermission.denied) {
//         // Request permission
//         permission = await Geolocator.requestPermission();
//       }

//       if (permission == LocationPermission.denied) {
//         ToastServices.warning(
//           'Permission Denied',
//           'Location access is needed to provide localized information.',
//         );
//         _isLocationPermissionGranted.value = false;
//         return false;
//       }

//       if (permission == LocationPermission.deniedForever) {
//         _showLocationPermissionDialog();
//         _isLocationPermissionGranted.value = false;
//         return false;
//       }

//       // 3. Permission granted (whileInUse or always)
//       _isLocationPermissionGranted.value = true;
      
//       // 4. Try getting the current location
//       bool locationSuccess = await _getCurrentLocation(showErrorToast: true);
//       return locationSuccess;

//     } catch (e) {
//       debugPrint('Error in requestLocationPermission: $e');
//       return false;
//     } finally {
//       _isRequestingLocation.value = false;
//       update();
//     }
//   }

//   /// Enforce location permission: keep prompting until granted
//   /// This shows blocking dialogs and loops until the user grants permission
//   /// or enables the location service. Use carefully on entry screens.
//   Future<void> enforceLocationPermission() async {
//     if (_isRequestingLocation.value) return;

//     try {
//       _isRequestingLocation.value = true;
//       update();

//       while (true) {
//         // Ensure location services (GPS) are enabled
//         final serviceEnabled = await _checkLocationServiceStatus();
//         if (!serviceEnabled) {
//           await _waitUntilServiceEnabled();
//           continue;
//         }

//         // Check permission state
//         LocationPermission permission = await Geolocator.checkPermission();

//         if (permission == LocationPermission.denied) {
//           permission = await Geolocator.requestPermission();
//           if (permission == LocationPermission.denied) {
//             // If still denied, show a small info and wait/re-request
//             await _showBlockingInfo(
//               title: 'Permission Required',
//               message: 'This application requires location access to continue.',
//             );
//           }
//           continue;
//         }

//         if (permission == LocationPermission.deniedForever) {
//           // Proactively guide user to app settings
//           await _showBlockingInfo(
//             title: 'Permission Required',
//             message: 'Location permission is permanently denied. Please enable it in App Settings.',
//             onConfirm: () async {
//               await ph.openAppSettings();
//             },
//           );
//           // After returning from settings, loop will re-check permission
//           continue;
//         }

//         if (permission == LocationPermission.whileInUse ||
//             permission == LocationPermission.always) {
//           _isLocationPermissionGranted.value = true;
//           await _getCurrentLocation(showErrorToast: true);
//           break;
//         }
        
//         // Safety break to prevent infinite rapid looping
//         await Future.delayed(const Duration(milliseconds: 500));
//       }
//     } catch (e) {
//       debugPrint('Error in enforceLocationPermission: $e');
//     } finally {
//       _isRequestingLocation.value = false;
//       update();
//     }
//   }

//   /// internal method to get current position
//   /// returns true if successful
//   Future<bool> _getCurrentLocation({bool showErrorToast = false}) async {
//     // Throttling: if we successfully fetched location in the last 15 seconds, skip unless forced
//     if (_lastFetchTime.value != null && 
//         DateTime.now().difference(_lastFetchTime.value!).inSeconds < 15 && 
//         hasValidLocation) {
//       debugPrint('Skipping location fetch, using cached value');
//       return true;
//     }

//     try {
//       // First try to get last known position (much faster)
//       Position? lastPosition = await Geolocator.getLastKnownPosition();
//       if (lastPosition != null) {
//         _lat.value = lastPosition.latitude;
//         _long.value = lastPosition.longitude;
//         // Don't return yet, try to get fresh accurate location if possible
//       }

//       Position position = await Geolocator.getCurrentPosition(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.high,
//           timeLimit: Duration(seconds: 15),
//         ),
//       );

//       _lat.value = position.latitude;
//       _long.value = position.longitude;
//       _lastFetchTime.value = DateTime.now();

//       debugPrint('Location obtained: ${_lat.value}, ${_long.value}');
//       return true;
//     } on TimeoutException {
//       debugPrint('Location fetch timed out');
//       if (showErrorToast && !hasValidLocation) {
//         ToastServices.error('Location Timeout', 'Fetching location took too long. Please try again.');
//       }
//       return false;
//     } catch (e) {
//       debugPrint('Error getting location: $e');
//       if (showErrorToast && !hasValidLocation) {
//         // ToastServices.error('Location Error', 'Could not get current location. Please check your GPS.');
//       }
//       return false;
//     }
//   }

//   Future<void> _showBlockingInfo({
//     required String title,
//     required String message,
//     FutureOr<void> Function()? onConfirm,
//   }) async {
//     await Get.dialog(
//       PopScope(
//         canPop: false,
//         child: AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 if (onConfirm != null) await onConfirm();
//                 Get.back();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       ),
//       barrierDismissible: false,
//     );
//   }

//   Future<void> _waitUntilServiceEnabled() async {
//     if (Get.isDialogOpen != true) {
//       await _showBlockingInfo(
//         title: 'Enable Location',
//         message: 'Please turn on Location (GPS) in device settings to continue.',
//         onConfirm: () async {
//           await Geolocator.openLocationSettings();
//         },
//       );
//     }
    
//     // Polling loop with backoff
//     int count = 0;
//     while (true) {
//       final enabled = await Geolocator.isLocationServiceEnabled();
//       if (enabled) {
//         if (Get.isDialogOpen == true) Get.back();
//         _isLocationServiceEnabled.value = true;
//         return;
//       }
//       await Future.delayed(const Duration(seconds: 2));
//       count++;
      
//       // After 30 seconds of waiting, maybe show the dialog again if it was dismissed somehow
//       if (count > 15 && Get.isDialogOpen != true) {
//         _waitUntilServiceEnabled();
//         return;
//       }
//     }
//   }

//   void _showLocationServiceDialog() {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Location Services Disabled'),
//         content: const Text(
//           'Please enable location services (GPS) to use this feature.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               Get.back();
//               await Geolocator.openLocationSettings();
//             },
//             child: const Text('Settings'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showLocationPermissionDialog() {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Location Permission Required'),
//         content: const Text(
//           'This app needs location permission to function correctly. '
//           'Please enable it in App Settings.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               Get.back();
//               await ph.openAppSettings();
//             },
//             child: const Text('Settings'),
//           ),
//         ],
//       ),
//     );
//   }

//   bool checkLocationAvailability() {
//     return hasValidLocation && isLocationPermissionGranted && isLocationServiceEnabled;
//   }

//   Future<void> refreshLocation() async {
//     // Only refresh if we already have permission, otherwise we might trigger unwanted prompts
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.whileInUse || 
//         permission == LocationPermission.always) {
//         _isLocationPermissionGranted.value = true;
//         await _getCurrentLocation(showErrorToast: false);
//     } else {
//         _isLocationPermissionGranted.value = false;
//     }
//   }

//   void resetLocation() {
//     _lat.value = 0.0;
//     _long.value = 0.0;
//     _lastFetchTime.value = null;
//     _isLocationPermissionGranted.value = false;
//     _isRequestingLocation.value = false;
//     update();
//   }
// }

