import 'package:get_storage/get_storage.dart';

import '../constants/local_storage_key_strings.dart';


/// Storage Debug Helper - Helps debug storage issues
class StorageDebugHelper {
  static final GetStorage _storage = GetStorage();
  
  /// Check if storage is working properly
  static Future<Map<String, dynamic>> debugStorage() async {
    Map<String, dynamic> debugInfo = {};
    
    try {
      
      const testKey = 'debug_test_key';
      const testValue = 'debug_test_value';
      
      // Test write
      await _storage.write(testKey, testValue);
      debugInfo['writeTest'] = 'success';
      
      // Test read
      final readValue = _storage.read(testKey);
      debugInfo['readTest'] = readValue == testValue ? 'success' : 'failed';
      
      // Clean up
      await _storage.remove(testKey);
      debugInfo['cleanupTest'] = 'success';
      
      // Check auth data
      debugInfo['authData'] = {
        'accessToken': _storage.read(LocalStorageKeyStrings.accessToken) != null,
        'refreshToken': _storage.read(LocalStorageKeyStrings.refreshToken) != null,
        'isLogin': _storage.read(LocalStorageKeyStrings.isLogin),
        'userId': _storage.read(LocalStorageKeyStrings.loggedInUserId) != null,
        'userName': _storage.read(LocalStorageKeyStrings.userName) != null,
        'phoneNumber': _storage.read('phoneNumber') != null,
      };
      
      // Check storage size
      debugInfo['storageSize'] = await _getStorageSize();
      
      debugInfo['status'] = 'success';
      
    } catch (e) {
      debugInfo['status'] = 'error';
      debugInfo['error'] = e.toString();
    }
    
    return debugInfo;
  }
  
  /// Get storage size
  static Future<int> _getStorageSize() async {
    try {
      // This is a rough estimate
      int size = 0;
      final keys = _storage.getKeys();
      for (String key in keys) {
        final value = _storage.read(key);
        if (value is String) {
          size += value.length;
        } else if (value is Map) {
          size += value.toString().length;
        }
      }
      return size;
    } catch (e) {
      return -1;
    }
  }
  
  /// Print storage debug info
  static Future<void> printStorageDebugInfo() async {
    
    
    final debugInfo = await debugStorage();
    
    
    
    if (debugInfo['authData'] != null) {
      final authData = debugInfo['authData'] as Map<String, dynamic>;
      authData.forEach((key, value) {
      });
    }
    
    
    if (debugInfo['error'] != null) {
    }
    
  }
  
  /// Force reinitialize storage
  static Future<bool> forceReinitializeStorage() async {
    try {
      
      // Clear all data first
      await _storage.erase();
      
      // Reinitialize
      await GetStorage.init('sangamner_ai_storage');
      
      // Test storage
      const testKey = 'reinit_test';
      const testValue = 'reinit_value';
      
      await _storage.write(testKey, testValue);
      final readValue = _storage.read(testKey);
      
      if (readValue == testValue) {
        await _storage.remove(testKey);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  
  /// Backup current storage data
  static Future<Map<String, dynamic>> backupStorageData() async {
    try {
      Map<String, dynamic> backup = {};
      final keys = _storage.getKeys();
      
      for (String key in keys) {
        backup[key] = _storage.read(key);
      }
      
      return backup;
    } catch (e) {
      return {};
    }
  }
  
  /// Restore storage data from backup
  static Future<bool> restoreStorageData(Map<String, dynamic> backup) async {
    try {
      
      // Clear current storage
      await _storage.erase();
      
      // Restore from backup
      for (String key in backup.keys) {
        await _storage.write(key, backup[key]);
      }
      
      return true;
    } catch (e) {
      return false;
    }
  }
}
