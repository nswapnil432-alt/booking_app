import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;
 
class DeviceHelper {
  static final _instance = DeviceHelper._internal();
  DeviceHelper._internal();
  factory DeviceHelper() {
    return _instance;
  }
 
  Future<String?> getDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
 
    if (kIsWeb) {
      final webInfo = await deviceInfo.webBrowserInfo;
      return webInfo.userAgent; // You can use browser name or userAgent as ID
    } else {
      try {
        // Only import Platform when not on web
        if (Platform.isAndroid) {
          final androidInfo = await deviceInfo.androidInfo;
          return androidInfo.id; // or androidId
        } else if (Platform.isIOS) {
          final iosInfo = await deviceInfo.iosInfo;
          return iosInfo.identifierForVendor;
        }
      } catch (e) {
        // Handle unsupported platform errors gracefully
        return 'Unknown';
      }
    }
 
    return null;
  }
}
 
 