class PermissionResponse {
  final bool? success;
  final String? message;
  final List<RolePermission>? data;

  PermissionResponse({this.success, this.message, this.data});

  factory PermissionResponse.fromJson(Map<String, dynamic> json) {
    return PermissionResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => RolePermission.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      if (data != null) 'data': data!.map((v) => v.toJson()).toList(),
    };
  }
}

class RolePermission {
  final String? rolePermissionId;
  final ModuleData? module;
  final PermissionData? permission;
  final List<String>? actions;

  RolePermission({
    this.rolePermissionId,
    this.module,
    this.permission,
    this.actions,
  });

  factory RolePermission.fromJson(Map<String, dynamic> json) {
    return RolePermission(
      rolePermissionId: json['role_permission_id'],
      module: json['module'] != null ? ModuleData.fromJson(json['module']) : null,
      permission: json['permission'] != null
          ? PermissionData.fromJson(json['permission'])
          : null,
      actions: json['actions'] != null ? List<String>.from(json['actions']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role_permission_id': rolePermissionId,
      if (module != null) 'module': module!.toJson(),
      if (permission != null) 'permission': permission!.toJson(),
      if (actions != null) 'actions': actions,
    };
  }
}

class ModuleData {
  final String? id;
  final String? name;
  final String? description;

  ModuleData({this.id, this.name, this.description});

  factory ModuleData.fromJson(Map<String, dynamic> json) {
    return ModuleData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

class PermissionData {
  final String? id;
  final String? name;
  final String? code;
  final String? description;
  final String? category;
  final String? moduleId;
  final bool? isSystem;

  PermissionData({
    this.id,
    this.name,
    this.code,
    this.description,
    this.category,
    this.moduleId,
    this.isSystem,
  });

  factory PermissionData.fromJson(Map<String, dynamic> json) {
    return PermissionData(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      description: json['description'],
      category: json['category'],
      moduleId: json['module_id'],
      isSystem: json['is_system'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'description': description,
      'category': category,
      'module_id': moduleId,
      'is_system': isSystem,
    };
  }
}
