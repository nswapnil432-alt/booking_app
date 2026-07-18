import 'package:flutter/material.dart';
import '../../extension/sized_box_extension.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/local_storage_key_strings.dart';
import '../../widgets/custom_toast_widget.dart';

class ToastServices {
  ToastServices._();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? _currentProgressToast;
  static ValueNotifier<int>? _progressNotifier;
  static ValueNotifier<String>? _progressTitleNotifier;

  static void showToast({
    required String title,
    required String message,
    required Color backgroundColor,
    required Color textColor,
    required Color bubbleColor,
    String? leadingIcon,
    String? trailingIcon,
    Duration duration = const Duration(seconds: 4),
  }) {
    if (LocalStorageKeyStrings.appNavKey.currentContext != null) {
      ScaffoldMessenger.of(LocalStorageKeyStrings.appNavKey.currentContext!)
          .showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          elevation: 20.0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.transparent,
          content: CustomToastWidget(
            title: title,
            message: message,
            backgroundColor: backgroundColor,
            textColor: textColor,
            leadingIcon: leadingIcon,
            trailingIcon: trailingIcon,
            bubbleColor: bubbleColor,
          ),
          duration: duration,
        ),
      );
    }
  }

  static void success(String title, String message) {
    showToast(
        title: title,
        message: message,
        backgroundColor: AppColors.successToastBgColor1,
        textColor: AppColors.whiteColor,
        // leadingIcon: AppImages.successToastIcon,
        // trailingIcon: AppImages.unionCancleIcon,
        bubbleColor: AppColors.successBubbleColor);
  }

  static void error(String title, String message) {
    showToast(
        title: title,
        message: message,
        backgroundColor: AppColors.errorToastBgColor1,
        textColor: AppColors.whiteColor,
        // leadingIcon: AppImages.errorToastIcon,
        // trailingIcon: AppImages.unionCancleIcon,
        bubbleColor: AppColors.errorBubbleColor);
  }

  static void warning(String title, String message) {
    showToast(
      title: title,
      message: message,
      backgroundColor: AppColors.warningToastBgColor,
      textColor: Colors.white,
      bubbleColor: AppColors.warningBubbleColor,
      // leadingIcon: AppImages.warningToastIcon,
    );
  }

  static void message(String title, String message) {
    showToast(
      title: title,
      message: message,
      backgroundColor: AppColors.messageToastBgColor,
      textColor: Colors.white,
      bubbleColor: AppColors.messageBubbleColor,
      leadingIcon: AppImages.messageToastIcon,
    );
  }

  static void info(String title, String message) {
    showToast(
      title: title,
      message: message,
      backgroundColor: AppColors.messageToastBgColor,
      textColor: Colors.white,
      bubbleColor: AppColors.messageBubbleColor,
      leadingIcon: AppImages.messageToastIcon,
    );
  }

  // Improved progress toast methods for download functionality
  static void showProgress(String message) {
    showProgressWithPercentage(message, 0);
  }

  static void updateProgress(String message) {
    final RegExp percentageRegex = RegExp(r'(\d+)%');
    final Match? match = percentageRegex.firstMatch(message);
    
    if (match != null) {
      final int percentage = int.parse(match.group(1)!);
      final String title = message.replaceAll(percentageRegex, '').trim();
      updateProgressWithPercentage(title.isEmpty ? 'Downloading' : title, percentage);
    } else {
      updateProgressWithPercentage('Downloading', 0);
    }
  }

  static void dismissProgress() {
    if (_currentProgressToast != null) {
      try {
        ScaffoldMessenger.of(
          LocalStorageKeyStrings.appNavKey.currentContext!,
        ).hideCurrentSnackBar();
        _currentProgressToast!.closed.then((_) {
          _disposeNotifiers();
        });
      } catch (e) {
        _disposeNotifiers();
      }
      _currentProgressToast = null;
    } else {
      _disposeNotifiers();
    }
  }

  // Helper method to safely dispose notifiers
  static void _disposeNotifiers() {
    try {
      _progressNotifier?.dispose();
    } catch (e) {
      // Ignore disposal errors
    }
    _progressNotifier = null;
    
    try {
      _progressTitleNotifier?.dispose();
    } catch (e) {
      // Ignore disposal errors
    }
    _progressTitleNotifier = null;
  }

  // Enhanced progress toast with determinate progress and smooth updates
// Enhanced progress toast with determinate progress and smooth updates
static void showProgressWithPercentage(String title, int percentage) {
  if (LocalStorageKeyStrings.appNavKey.currentContext != null) {
    // Initialize notifiers if not already done
    _progressNotifier ??= ValueNotifier<int>(0);
    _progressTitleNotifier ??= ValueNotifier<String>(title);
    
    // Update values
    _progressNotifier!.value = percentage.clamp(0, 100);
    _progressTitleNotifier!.value = title;
    
    // Only create new toast if one doesn't exist
    _currentProgressToast ??= ScaffoldMessenger.of(
        LocalStorageKeyStrings.appNavKey.currentContext!,
      ).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          elevation: 20.0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.transparent,
          duration: const Duration(days: 1), 
          content: ValueListenableBuilder<int>(
            valueListenable: _progressNotifier!,
            builder: (context, progress, child) {
              return ValueListenableBuilder<String>(
                valueListenable: _progressTitleNotifier!,
                builder: (context, currentTitle, child) {
                  return CustomToastWidget(
                    backgroundColor: AppColors.successToastBgColor1,
                    textColor: AppColors.whiteColor,
                    // leadingIcon: AppImages.successToastIcon,
                    // trailingIcon: AppImages.unionCancleIcon,
                    bubbleColor: AppColors.successBubbleColor,
                    title: currentTitle,
                    message: progress == 100 ? 'Completing...' : 'Please wait...',
                    // Pass progress data as custom content
                    customContent: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                currentTitle,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            8.width,
                            Text(
                              '$progress%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        8.height,
                        LinearProgressIndicator(
                          value: progress / 100,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          minHeight: 4,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        4.height,
                        Text(
                          progress == 100 ? 'Completing...' : 'Please wait...',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
  }
}
  // Method to update existing progress toast without recreating it
  static void updateProgressWithPercentage(String title, int percentage) {
    if (_progressNotifier != null && _progressTitleNotifier != null) {
      // Check if notifiers are not disposed before updating
      try {
        _progressNotifier!.value = percentage.clamp(0, 100);
        _progressTitleNotifier!.value = title;
      } catch (e) {
        // If notifiers are disposed, create new ones
        showProgressWithPercentage(title, percentage);
      }
    } else {
      // If no progress toast exists, create one
      showProgressWithPercentage(title, percentage);
    }
  }


  // Helper method to dismiss all toasts
  static void dismissAll() {
    if (LocalStorageKeyStrings.appNavKey.currentContext != null) {
      try {
        ScaffoldMessenger.of(
          LocalStorageKeyStrings.appNavKey.currentContext!,
        ).clearSnackBars();
      } catch (e) {
        // Handle any errors when clearing snackbars
      }
    }
    
    _currentProgressToast = null;
    _disposeNotifiers();
  }
}