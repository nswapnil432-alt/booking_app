class LikeUser {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? name;
  final String? profileImage;

  const LikeUser({
    this.id,
    this.firstName,
    this.lastName,
    this.name,
    this.profileImage,
  });

  String get displayName {
    final String composed = '${firstName ?? ''} ${lastName ?? ''}'.trim();
    if (composed.isNotEmpty) return composed;
    if (name != null && name!.trim().isNotEmpty) return name!.trim();
    return 'User';
  }

  factory LikeUser.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? user;
    final dynamic rawUser = json['user'];
    if (rawUser is Map<String, dynamic>) user = rawUser;

    return LikeUser(
      id: (json['id'] ?? user?['id'] ?? user?['user_id'])?.toString(),
      firstName: (user?['first_name'] ?? user?['firstName'])?.toString(),
      lastName: (user?['last_name'] ?? user?['lastName'])?.toString(),
      name: (user?['name'] ?? json['name'])?.toString(),
      profileImage:
          (user?['profile_image'] ?? user?['profileImage'])?.toString(),
    );
  }
}

