class LoginRequestModel {
  final String phone;
  final String password;

  LoginRequestModel({
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }
}

class LoginResponseModel {
  final String? token;
  final String? error;

  LoginResponseModel({
    this.token,
    this.error,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] as String?,
      error: json['error'] as String?,
    );
  }
}
