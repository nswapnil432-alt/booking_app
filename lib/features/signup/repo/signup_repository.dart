class SignupRepository {
  Future<Map<String, dynamic>?> register({
    required String fullName,
    required String phone,
    required String location,
    required String password,
    String? profilePhotoPath,
  }) async {
    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 1));
      return {
        "success": true,
        "message": "Account created successfully",
        "user": {
          "name": fullName,
          "phone": phone,
          "location": location,
        }
      };
    } catch (e) {
      return null;
    }
  }
}
