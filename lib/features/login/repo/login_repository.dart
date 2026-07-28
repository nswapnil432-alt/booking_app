class LoginRepository {
  Future<Map<String, dynamic>?> login(String phone, String password) async {
    // API request structure
    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 1));
      return {
        "success": true,
        "token": "dummy_token_12345",
        "user": {
          "phone": phone,
        }
      };
    } catch (e) {
      return null;
    }
  }
}
