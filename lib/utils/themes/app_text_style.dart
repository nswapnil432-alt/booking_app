import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTextStyle {
  const AppTextStyle._();

  ///Font family
  static const String fontFamily = "Figtree";
  static TextStyle regularTextStyle = const TextStyle(fontFamily: 'Figtree');

  static TextStyle veryLargeHeader = const TextStyle(
    color: AppColors.black,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static TextStyle largeHeader = const TextStyle(
    color: AppColors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static TextStyle mediumHeader = const TextStyle(
    color: AppColors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static TextStyle smallHeader = const TextStyle(
    color: AppColors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static TextStyle largeNormalText = const TextStyle(
    color: AppColors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle mediumNormalText = const TextStyle(
    color: AppColors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle smallNormalText = const TextStyle(
    color: AppColors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle hintStyle = const TextStyle(
    color: AppColors.hintTextColor,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle headingStyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  static TextStyle bodyStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamily,
  );

  static TextStyle labelStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontFamily: fontFamily,
  );

  static TextStyle buttonTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );
  static const TextStyle alreadyAccountText = TextStyle(
    color: AppColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static const TextStyle loginText = TextStyle(
    color: Colors.blueAccent,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );
}
