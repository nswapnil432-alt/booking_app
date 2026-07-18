import 'package:flutter/material.dart';
import '../constants/app_images.dart';
import '../constants/app_colors.dart';
import '../extension/sized_box_extension.dart';
import '../themes/app_text_style.dart';

class DataNotFoundWidget extends StatelessWidget {
  final String title;
  final String description;

  const DataNotFoundWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.dataNotfound,
              height: 250,
              width: 250,
              fit: BoxFit.contain,
            ),
            5.height,
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle.largeHeader.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlueColors, // or darkBlueColor
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyStyle.copyWith(
                fontSize: 16,
                color: AppColors.greyTextColor,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
