// import 'package:get/get.dart';
// import '../../core/models/permission_model.dart';
// import '../widgets/auth_storage_helper.dart';
// import '../misc/logger_service.dart';
// import '../networks/end_point.dart';
// import '../networks/network_service.dart';
// class PermissionService extends GetxService {
//   static PermissionService get to => Get.find();

//   final RxList<RolePermission> permissions = <RolePermission>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchPermissionsFromApi(AuthStorageHelper.roleId.toString());
//     _loadPermissionsFromStorage();
//   }

//   void _loadPermissionsFromStorage() {
//     try {
//       final savedPermissions = AuthStorageHelper.permissions;
//       if (savedPermissions != null && savedPermissions.isNotEmpty) {
//         permissions.assignAll(savedPermissions);
//       }
//     } catch (e) {
//       LoggerService.log("Error loading permissions from storage: $e");
//     }
//   }

//   /// Fetches from API using roleId and clientId
//   Future<void> fetchPermissionsFromApi(String roleId) async {
//     try {
//       if (roleId.isEmpty || roleId.toLowerCase() == 'null') return;
//       final clientId = AuthStorageHelper.clientId ?? EndPoint.clientId;
//       if (clientId.isEmpty || clientId.toLowerCase() == 'null') return;
      
      
//       final networkService = getIt<NetworkService>();
//       final dynamic response = await networkService.getRequest(
//         EndPoint.getRolePermissionsUrl(clientId, roleId),
//       );

//       final permResponse = PermissionResponse.fromJson(response);
      
//       if (permResponse.success == true && permResponse.data != null) {
//         setPermissions(permResponse.data!);
//         LoggerService.log("Fetched and mapped ${permResponse.data!.length} permissions successfully.");
//       }
//     } catch (e) {
//       LoggerService.log("Error fetching permissions: $e");
//     }
//   }

//   /// Sets the permissions after successful login and fetching the api response
//   void setPermissions(List<RolePermission> fetchedPermissions) {
//     permissions.assignAll(fetchedPermissions);
//     AuthStorageHelper.savePermissions(fetchedPermissions);
//   }

//   /// Clears stored permissions on logout
//   void clearPermissions() {
//     permissions.clear();
//   }

//   /// Check if the user has access to a specific module code with an optional required action
//   bool hasPermission(String moduleCode, {String requiredAction = 'read'}) {
//     // If the list is completely empty, you might want to consider returning a default
//     // Currently, it evaluates to false unless explicitly permitted.
//     // Bypass permission check for Admin and Super Admin roles
//     final role = AuthStorageHelper.userRole?.toLowerCase() ?? '';
//     final rName = AuthStorageHelper.roleName?.toLowerCase() ?? '';
//     final loginResp = AuthStorageHelper.loginResponse;
//     final clientId = AuthStorageHelper.clientId;

//     // Deep check in user_mappings for 'admin' roles
//     bool isSuperAdmin = role.contains('admin') || rName.contains('admin');
    
//     if (!isSuperAdmin && loginResp != null && loginResp['user'] != null) {
//       final user = loginResp['user'];
//       // 1. check top-level type
//       final userTypeStr = (user['type'] ?? loginResp['user_type'] ?? '').toString().toLowerCase();
//       if (userTypeStr.contains('admin')) isSuperAdmin = true;

//       // 2. check user_mappings list
//       if (!isSuperAdmin && user['user_mappings'] != null) {
//         final List mappings = user['user_mappings'];
//         for (var mapping in mappings) {
//           if (mapping['role'] != null) {
//             final String mRole = (mapping['role']['name'] ?? '').toString().toLowerCase();
//             if (mRole.contains('admin')) {
//               // Only if it's the current client or if we want general admin bypass
//               if (clientId == null || mapping['client_id'] == clientId) {
//                 isSuperAdmin = true;
//                 break;
//               }
//             }
//           }
//         }
//       }
//     }

//     if (isSuperAdmin) {
//       return true;
//     }

//     for (var rp in permissions) {
//       if (rp.permission?.code?.toLowerCase() == moduleCode.toLowerCase()) {
//         if (rp.actions != null) {
//           final hasAction = rp.actions!.any(
//             (action) =>
//                 action != null &&
//                 action.toLowerCase() == requiredAction.toLowerCase(),
//           );
//           if (hasAction) return true;
//         }
//       }
//     }
//     return false;
//   }
// }
