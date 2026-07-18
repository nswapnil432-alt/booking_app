import 'package:flutter/material.dart';
import '../extension/sized_box_extension.dart';
import '../themes/app_text_style.dart';

class NoDataFoundScreen extends StatelessWidget {
  final String title;
  final String message;
  final String primaryButtonText;
  final String secondaryButtonText;
  final String supportText;
  final Color primaryColor;
  final Color backgroundColor;
  final Color textColor;
  final double iconSize;
  final VoidCallback? onPrimaryButtonPressed;
  final VoidCallback? onSecondaryButtonPressed;
  final IconData noDataIcon;

  const NoDataFoundScreen({
    super.key,
    this.title = 'No Data Found',
    this.message =
        'We couldn\'t load the data you\'re looking for. Our app might be updating or experiencing temporary issues.',
    this.primaryButtonText = 'Refresh',
    this.secondaryButtonText = 'Go Back',
    this.supportText = 'If this problem persists, please contact support.',
    this.primaryColor = const Color(0xFF3F51B5),
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.iconSize = 100,
    this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
    this.noDataIcon = Icons.cloud_off_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                noDataIcon,
                size: iconSize,
                color: primaryColor,
              ),
              30.height,
              Text(
                title,
                style: AppTextStyle.mediumHeader.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
              16.height,
              Text(
                message,
                style: AppTextStyle.mediumNormalText.copyWith(
                  fontSize: 16,
                  color: textColor.withValues(alpha: 0.7),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              40.height,
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: onPrimaryButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    primaryButtonText,
                    style: AppTextStyle.mediumNormalText.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor
                    ),
                  ),
                ),
              ),
              16.height,
              SizedBox(
                width: double.infinity,
                height: 48,
                child: TextButton(
                  onPressed:
                      onSecondaryButtonPressed ?? () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    foregroundColor: textColor.withValues(alpha: 0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    secondaryButtonText,
                    style: AppTextStyle.mediumNormalText.copyWith(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              40.height,
              Text(
                supportText,
                style: AppTextStyle.mediumNormalText.copyWith(
                  fontSize: 14,
                  color: textColor.withValues(alpha: 0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// this is example use code 

//  NoDataFoundScreen(
//         title: 'No Data Available',
//         message: 'We couldn\'t find the data you\'re looking for. The app might be updating or experiencing connection issues.',
//         primaryButtonText: 'Try Again',
//         secondaryButtonText: 'Back to Home',
//         supportText: 'Contact support if this problem continues',
//         primaryColor: AppColors.parentBgColor,
//         backgroundColor: AppColors.backgroundColor,
//         textColor: AppColors.white, 
//         iconSize: 120,
//         noDataIcon: Icons.cloud_off_rounded, 
//         onPrimaryButtonPressed: () {
//           print('Refreshing data...');
//         },
//         onSecondaryButtonPressed: () {
//           print('Navigating to home...');
//         },
//       ),