class SignupRequestModel {
  final String fullName;
  final String phone;
  final String location;
  final String password;
  final String? profilePhotoPath;

  SignupRequestModel({
    required this.fullName,
    required this.phone,
    required this.location,
    required this.password,
    this.profilePhotoPath,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'phone': phone,
      'location': location,
      'password': password,
      'profile_photo_path': profilePhotoPath,
    };
  }
}
