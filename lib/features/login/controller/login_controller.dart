import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  
  final RxBool obscureText = true.obs;
  final RxBool isLoading = false.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void login(BuildContext context, VoidCallback onSuccess) {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      
      // Simulate API login request
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
        onSuccess();
      });
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
