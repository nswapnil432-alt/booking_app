import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/navigation/app_routes.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

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
                      const SizedBox(height: 30),
                      // Diya Logo/Icon
                      const DiyaWidget(),
                      const SizedBox(height: 16),
                      
                      // App Title (SevaSur)
                      const Text(
                        "SevaSur",
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5D2E16),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      
                      // Subtitle (सेवा • सूर • संगीत)
                      const Text(
                        "सेवा • सूर • संगीत",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF7C5D4B),
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Message (Welcome back. Sign in to continue your seva.)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Welcome back. Sign in to continue your seva.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8B7365),
                            fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  
                  // The Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
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
                          // Phone Number field
                          _CustomInputField(
                            label: "PHONE NUMBER",
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
                          const SizedBox(height: 24),
                          
                          // Password field
                          Obx(() => _CustomInputField(
                            label: "PASSWORD",
                            hintText: "........",
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
                              if (value.trim().length < 6) {
                                return "Password must be at least 6 characters long";
                              }
                              return null;
                            },
                          )),
                          const SizedBox(height: 36),
                          
                          // Sign in button with gradient
                          Obx(() => GestureDetector(
                            onTap: controller.isLoading.value
                                ? null
                                : () {
                                    controller.login(context, () {
                                      context.go(AppRoutes.home);
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
                                        "Sign in",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          )),
                          const SizedBox(height: 24),
                          
                          // New here? Create an account footer
                          Center(
                            child: InkWell(
                              onTap: () {
                                context.push(AppRoutes.signUp);
                              },
                              child: RichText(
                                text: const TextSpan(
                                  text: "New here? ",
                                  style: TextStyle(
                                    color: Color(0xFF8B7365),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Create an account",
                                      style: TextStyle(
                                        color: Color(0xFFD35515),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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

class DiyaWidget extends StatelessWidget {
  const DiyaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 12,
            child: Container(
              width: 70,
              height: 42,
              decoration: const BoxDecoration(
                color: Color(0xFF2C1E18),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            child: Container(
              width: 66,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFDE7432),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            child: Container(
              width: 50,
              height: 12,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 2.5,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 38,
            left: 28,
            child: RotationTransition(
              turns: const AlwaysStoppedAnimation(-15 / 360),
              child: Container(
                width: 6,
                height: 14,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF5E9),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          Positioned(
            top: 6,
            left: 20,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFD54F).withValues(alpha: 0.35),
                    blurRadius: 20,
                    spreadRadius: 8,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 24,
            child: ClipPath(
              clipper: FlameClipper(),
              child: Container(
                width: 32,
                height: 42,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFFE65100),
                      Color(0xFFFFB300),
                      Color(0xFFFFF9C4),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FlameClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.cubicTo(
      size.width * 0.9, size.height * 0.45,
      size.width, size.height * 0.75,
      size.width / 2, size.height,
    );
    path.cubicTo(
      0, size.height * 0.75,
      size.width * 0.1, size.height * 0.45,
      size.width / 2, 0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
