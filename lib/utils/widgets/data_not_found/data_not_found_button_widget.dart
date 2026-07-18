import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/local_storage_key_strings.dart';
import '../../extension/sized_box_extension.dart';
import '../../localiization/localization_extension.dart';
import '../../themes/app_text_style.dart';
import '../buttons/primary_elevated_button.dart';

class DataNotFoundButtonWidget extends StatelessWidget {
  final bool buttonActive;
  final String? title;
  const DataNotFoundButtonWidget({
    super.key,
    this.buttonActive = true,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.dataNotFound),
          10.height,
          Text(
            title ?? context.noDataSafe,
            style: AppTextStyle.mediumNormalText.copyWith(
              color: AppColors.textGrayColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          10.height,
          Column(
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: AppColors.textGrayColor.withValues(alpha: 0.5),
              ),
              8.height,
              Text(
                context.noInfoSafe,
                style: AppTextStyle.mediumNormalText.copyWith(
                  color: AppColors.textGrayColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              8.height,
              Text(
                context.tryDifferentKeywordsSafe,
                style: AppTextStyle.hintStyle.copyWith(
                  color: AppColors.textGrayColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          20.height,
          if (buttonActive)
            PrimaryElevatedButton(
              label: context.goToDashboardSafe,
              buttonColor: AppColors.parentBgColor,
              onPressed: () {
                LocalStorageKeyStrings.appNavKey.currentContext?.pop();
              },
            ),
        ],
      ),
    );
  }
}
