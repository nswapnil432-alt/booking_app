import 'package:get_storage/get_storage.dart';
import '../misc/logger_service.dart';
import 'dart:convert';
import '../../core/models/permission_model.dart';

import '../constants/local_storage_key_strings.dart';

class AuthStorageHelper {
  static final GetStorage _storage = GetStorage();

  static Future<void> saveLoginResponse(Map<String, dynamic> response) async {
    try {
      // Check if GetStorage is initialized
      // if (!GetStorage.initStorage) {
      //   await GetStorage.init('sangamner_ai_storage');
      // }
      
      // Handle OTP verification response with tokenResponse object
      Map<String, dynamic>? tokenResponse;
      if (response.containsKey('tokenResponse') && response['tokenResponse'] is Map<String, dynamic>) {
        tokenResponse = response['tokenResponse'] as Map<String, dynamic>;
      }
      
      // Normalize common key variants from API
      final String? accessToken = tokenResponse != null
          ? (tokenResponse['access_token'] ?? tokenResponse['accessToken']) as String?
          : (response['access_token'] ?? response['accessToken'] ?? response['token']) as String?;
      
      final String? refreshToken = tokenResponse != null
          ? (tokenResponse['refresh_token'] ?? tokenResponse['refreshToken']) as String?
          : (response['refresh_token'] ?? response['refreshToken']) as String?;
      
      final String? userId = tokenResponse != null
          ? (tokenResponse['user']?['id'] ?? tokenResponse['userId']) as String?
          : (response['userId'] ?? response['user_id'] ?? response['user']?['id']) as String?;
      final String? clientId =
          (response['clientId'] ?? response['client_id']) as String?;
      
      final String? userName = tokenResponse != null
          ? (tokenResponse['user']?['name'] ?? tokenResponse['userName'] ?? tokenResponse['user_name']) as String?
          : (response['user']?['name'] ?? response['userName'] ?? response['user_name'] ?? response['name']) as String?;
      
      final String? clientName =
          (response['clientName'] ?? response['client_name']) as String?;
      
      String? userRole = tokenResponse != null
          ? (tokenResponse['user']?['type'] ?? tokenResponse['userRole'] ?? tokenResponse['user_role'] ?? tokenResponse['role']) as String?
          : (response['user']?['type'] ?? response['userRole'] ?? response['user_role'] ?? response['role']) as String?;
      
      final String? profileImage =
          (response['profileImage'] ?? response['profile_image'] ?? response['user']?['profile_image']) as String?;
      
      final String? roleId =
          (response['roleId'] ?? response['role_id']) as String?;
      
      String? roleName = (response['roleName'] ?? response['role_name']) as String?;

      // Deep extraction from user_mappings if roleName is not at top level
      if ((roleName == null || roleName.isEmpty) && 
          response['user'] != null && 
          response['user']['user_mappings'] != null) {
        final List mappings = response['user']['user_mappings'];
        if (mappings.isNotEmpty) {
          // Look for current clientId mapping
          final mapping = mappings.firstWhere(
            (m) => m['client_id'] == clientId,
            orElse: () => mappings.first,
          );
          if (mapping['role'] != null) {
            roleName = mapping['role']['name'];
            userRole ??= roleName;
          }
        }
      }

      // Save access token
      if (accessToken != null) {
        await _storage.write(LocalStorageKeyStrings.accessToken, accessToken);
      }
      
      // Save refresh token
      if (refreshToken != null) {
        await _storage.write(LocalStorageKeyStrings.refreshToken, refreshToken);
      }
      
      // Save user ID
      if (userId != null) {
        await _storage.write(LocalStorageKeyStrings.loggedInUserId, userId);
      }
      
      // Save client ID
      if (clientId != null) {
        await _storage.write(LocalStorageKeyStrings.clientId, clientId);
      }
      
      // Save user name
      if (userName != null) {
        await _storage.write(LocalStorageKeyStrings.userName, userName);
      }
      
      // Save phone number from tokenResponse or direct response
      final String? phoneNumber = tokenResponse != null
          ? (tokenResponse['user']?['phone'] ?? tokenResponse['phone']) as String?
          : (response['phone'] ?? response['phoneNumber']) as String?;
      if (phoneNumber != null) {
        await _storage.write('phoneNumber', phoneNumber);
      }
      
      // Save client name
      if (clientName != null) {
        await _storage.write(LocalStorageKeyStrings.clientName, clientName);
      }
      
      // Save user role
      if (userRole != null) {
        await _storage.write(LocalStorageKeyStrings.userRole, userRole);
      }
      
      // Save profile image
      if (profileImage != null) {
        await _storage.write(LocalStorageKeyStrings.profileImage, profileImage);
      }
      
      // Save role ID
      if (roleId != null) {
        await _storage.write(LocalStorageKeyStrings.roleId, roleId);
      }
      
      // Save role name
      if (roleName != null) {
        print("role name is the :- $roleName ");
        await _storage.write(LocalStorageKeyStrings.roleName, roleName);
      }
      
      // Save designation name
      if (response['designationName'] != null) {
        await _storage.write(LocalStorageKeyStrings.designationName, response['designationName']);
      }
      
      // Save admission ID
      if (response['admissionId'] != null) {
        await _storage.write(LocalStorageKeyStrings.admissionId, response['admissionId']);
      }
      
      // Save hostel admission ID
      if (response['hostelAdmissionId'] != null) {
        await _storage.write(LocalStorageKeyStrings.hostelAddmissionId, response['hostelAdmissionId']);
      }
      
      // Save complete login response
      await _storage.write(LocalStorageKeyStrings.loginResp, response);
      
      // Set login status
      await _storage.write(LocalStorageKeyStrings.isLogin, true);
      
      // Verify storage
      await _verifyStorageData();
      
    } catch (e) {
      throw Exception('Failed to save login response: $e');
    }
  }
  
  // Verify storage data
  static Future<void> _verifyStorageData() async {
    try {
      final accessToken = _storage.read(LocalStorageKeyStrings.accessToken);
      final refreshToken = _storage.read(LocalStorageKeyStrings.refreshToken);
      final isLogin = _storage.read(LocalStorageKeyStrings.isLogin);
  
      
      if (accessToken == null || refreshToken == null || isLogin != true) {
        throw Exception('Storage verification failed - critical data missing');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> clearLoginData() async {
    try {
      print('🧹 Clearing login data...');
      
      await _storage.remove(LocalStorageKeyStrings.accessToken);
      await _storage.remove(LocalStorageKeyStrings.refreshToken);
      await _storage.remove(LocalStorageKeyStrings.loggedInUserId);
      await _storage.remove(LocalStorageKeyStrings.clientId);
      await _storage.remove(LocalStorageKeyStrings.userName);
      await _storage.remove('phoneNumber');
      await _storage.remove(LocalStorageKeyStrings.clientName);
      await _storage.remove(LocalStorageKeyStrings.userRole);
      await _storage.remove(LocalStorageKeyStrings.profileImage);
      await _storage.remove(LocalStorageKeyStrings.roleId);
      await _storage.remove(LocalStorageKeyStrings.roleName);
      await _storage.remove(LocalStorageKeyStrings.designationName);
      await _storage.remove(LocalStorageKeyStrings.admissionId);
      await _storage.remove(LocalStorageKeyStrings.hostelAddmissionId);
      await _storage.remove(LocalStorageKeyStrings.loginResp);
      await _storage.remove(LocalStorageKeyStrings.userProfile);
      await _storage.remove('user_permissions');
      await _storage.write(LocalStorageKeyStrings.isLogin, false);
      
    } catch (e) {
      throw Exception('Failed to clear login data: $e');
    }
  }

  static bool get isLoggedIn {
    return _storage.read(LocalStorageKeyStrings.isLogin) ?? false;
  }
  
  // Check storage persistence
  static Future<bool> checkStoragePersistence() async {
    try {
      // Test write and read
      const testKey = 'storage_test_key';
      const testValue = 'storage_test_value';
      
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
  
  // Get storage info
  static Map<String, dynamic> getStorageInfo() {
    try {
      return {
        // 'isInitialized': GetStorage.initStorage,
        'accessToken': _storage.read(LocalStorageKeyStrings.accessToken) != null,
        'refreshToken': _storage.read(LocalStorageKeyStrings.refreshToken) != null,
        'isLogin': _storage.read(LocalStorageKeyStrings.isLogin),
        'userId': _storage.read(LocalStorageKeyStrings.loggedInUserId) != null,
        'userName': _storage.read(LocalStorageKeyStrings.userName) != null,
        'phoneNumber': _storage.read('phoneNumber') != null,
      };
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  static String? get accessToken {
    return _storage.read(LocalStorageKeyStrings.accessToken);
  }

  static String? get refreshToken {
    return _storage.read(LocalStorageKeyStrings.refreshToken);
  }

  static String? get userId {
    return _storage.read(LocalStorageKeyStrings.loggedInUserId);
  }

  static Future<String?> getUserId() async {
    return _storage.read(LocalStorageKeyStrings.loggedInUserId);
  }

  static String? get clientId {
    return _storage.read(LocalStorageKeyStrings.clientId);
  }

  static String? get userName {
    return _storage.read(LocalStorageKeyStrings.userName);
  }

  static String? get phoneNumber {
    return _storage.read('phoneNumber');
  }

  static String? get clientName {
    return _storage.read(LocalStorageKeyStrings.clientName);
  }

  static String? get clientLogo {
    return _storage.read(LocalStorageKeyStrings.clientLogo);
  }

  static String? get userRole {
    return _storage.read(LocalStorageKeyStrings.userRole);
  }

  static String? get profileImage {
    return _storage.read(LocalStorageKeyStrings.profileImage);
  }

  static String? get roleId {
    return _storage.read(LocalStorageKeyStrings.roleId);
  }

  static String? get roleName {
    return _storage.read(LocalStorageKeyStrings.roleName);
  }

  static String? get designationName {
    return _storage.read(LocalStorageKeyStrings.designationName);
  }

  static String? get admissionId {
    return _storage.read(LocalStorageKeyStrings.admissionId);
  }

  static String? get hostelAdmissionId {
    return _storage.read(LocalStorageKeyStrings.hostelAddmissionId);
  }

  static Map<String, dynamic>? get loginResponse {
    return _storage.read(LocalStorageKeyStrings.loginResp);
  }

  // --- Permission Storage ---
  static Future<void> savePermissions(List<RolePermission> permissions) async {
    try {
      final List<Map<String, dynamic>> jsonList = permissions.map((p) => p.toJson()).toList();
      await _storage.write('user_permissions', jsonEncode(jsonList));
    } catch (e) {
      LoggerService.log('Error saving permissions : $e');
    }
  }

  static List<RolePermission>? get permissions {
    try {
      final String? jsonString = _storage.read('user_permissions');
      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => RolePermission.fromJson(json)).toList();
      }
    } catch (e) {
      LoggerService.log('Error parsing permissions : $e');
    }
    return null;
  }
}
