import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/navigation/app_routes.dart';
import '../controller/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFF2E1), // Warm cream at the top
                Color(0xFFFFF7EF), // Very light soft cream
                Color(0xFFFFFDF9), // Near white at the bottom
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      
                      // Title (Create your account)
                      const Text(
                        "Create your account",
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5D2E16),
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Subtitle (Join SevaSur. You can offer services later from your profile.)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Join SevaSur. You can offer services later from your profile.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8B7365),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // White Card Container
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 28.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // FULL NAME field
                              _CustomInputField(
                                label: "FULL NAME *",
                                hintText: "Your name",
                                prefixIcon: Icons.person_outline,
                                controller: controller.fullNameController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Full name is required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              
                              // PHONE NUMBER field
                              _CustomInputField(
                                label: "PHONE NUMBER *",
                                hintText: "98765 43210",
                                prefixIcon: Icons.phone_outlined,
                                controller: controller.phoneController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Phone number is required";
                                  }
                                  if (value.trim().length < 10) {
                                    return "Please enter a valid 10-digit phone number";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              
                              // LOCATION field
                              _CustomInputField(
                                label: "LOCATION *",
                                hintText: "Your city",
                                prefixIcon: Icons.location_on_outlined,
                                controller: controller.locationController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Location is required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              
                              // PASSWORD field
                              Obx(() => _CustomInputField(
                                label: "PASSWORD *",
                                hintText: "At least 4 characters",
                                prefixIcon: Icons.lock_outline,
                                controller: controller.passwordController,
                                obscureText: controller.obscureText.value,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.obscureText.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: const Color(0xFF8C7456),
                                  ),
                                  onPressed: controller.toggleObscureText,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Password is required";
                                  }
                                  if (value.trim().length < 4) {
                                    return "Password must be at least 4 characters";
                                  }
                                  return null;
                                },
                              )),
                              const SizedBox(height: 24),
                              
                              // PROFILE PHOTO upload field
                              const Text(
                                "PROFILE PHOTO",
                                style: TextStyle(
                                  color: Color(0xFF8C7456),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(height: 8),
                              InkWell(
                                onTap: () {
                                  // Simulate Image Selection
                                  controller.chooseProfilePhoto("profile_image.png");
                                  Get.snackbar(
                                    "Profile Photo",
                                    "Simulated image selection: profile_image.png",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: const Color(0xFFFFF2E1),
                                    colorText: const Color(0xFF5D2E16),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 64,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1E4D3),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Color(0xFF8C7456),
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Obx(() => Text(
                                        controller.profilePhotoPath.value != null
                                            ? controller.profilePhotoPath.value!
                                            : "Choose File No file chosen",
                                        style: TextStyle(
                                          color: controller.profilePhotoPath.value != null
                                              ? const Color(0xFF5D2E16)
                                              : const Color(0xFF8B7365),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Footer Message below the card
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Want to offer your own services? After signing in, open your profile and add a service category there.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8B7365),
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Create account Button
                      Obx(() => GestureDetector(
                        onTap: controller.isLoading.value
                            ? null
                            : () {
                                controller.register(context, () {
                                  Get.snackbar(
                                    "Success",
                                    "Account created successfully!",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                  );
                                  context.go(AppRoutes.login);
                                });
                              },
                        child: Container(
                          width: double.infinity,
                          height: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFD35515), // Deep orange
                                Color(0xFFE28B2E), // Orange-yellow gradient
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFD35515).withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: controller.isLoading.value
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
                                    "Create account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      )),
                      const SizedBox(height: 20),
                      
                      // Back to login button
                      TextButton(
                        onPressed: () {
                          context.go(AppRoutes.login);
                        },
                        child: const Text(
                          "Already have an account? Sign in",
                          style: TextStyle(
                            color: Color(0xFFD35515),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                // Loading Overlay
                Obx(() => controller.isLoading.value
                    ? Container(
                        color: Colors.black.withValues(alpha: 0.3),
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD35515)),
                          ),
                        ),
                      )
                    : const SizedBox.shrink()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;

  const _CustomInputField({
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.inputFormatters,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF8C7456),
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: const TextStyle(
            color: Color(0xFF6E553A),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFFC7B197),
              fontSize: 16,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: const Color(0xFF8C7456),
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: const Color(0xFFFBF1E5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Color(0xFFE2C9AB), width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
