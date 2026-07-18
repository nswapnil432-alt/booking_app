import 'package:flutter/material.dart';
import '../extension/sized_box_extension.dart';
import '../constants/app_colors.dart';
import '../themes/app_text_style.dart';

/// A reusable widget to display API error states with retry functionality
class ApiErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;
  final double height;
  final IconData icon;
  final Color? iconColor;
  final String retryButtonText;

  const ApiErrorWidget({
    super.key,
    required this.errorMessage,
    this.onRetry,
    this.height = 300,
    this.icon = Icons.error_outline_rounded,
    this.iconColor,
    this.retryButtonText = 'Retry',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 64,
                color: iconColor ?? AppColors.black.withValues(alpha: 0.4),
              ),
              20.height,
              Text(
                errorMessage,
                style: AppTextStyle.mediumNormalText.copyWith(
                  fontSize: 16,
                  color: AppColors.black.withValues(alpha: 0.7),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                24.height,
                SizedBox(
                  width: 160,
                  height: 44,
                  child: ElevatedButton.icon(
                    onPressed: onRetry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.refresh, size: 20),
                    label: Text(
                      retryButtonText,
                      style: AppTextStyle.mediumNormalText.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
