import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();

  final RxnString profilePhotoPath = RxnString();
  final RxBool obscureText = true.obs;
  final RxBool isLoading = false.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void chooseProfilePhoto(String path) {
    profilePhotoPath.value = path;
  }

  void register(BuildContext context, VoidCallback onSuccess) {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      
      // Simulate API sign up
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        onSuccess();
      });
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    locationController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
