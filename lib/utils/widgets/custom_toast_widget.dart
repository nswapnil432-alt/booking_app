// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_images.dart';
import '../themes/app_text_style.dart';

class CustomToastWidget extends StatelessWidget {
  final String? leadingIcon;
  final String title;
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final String? trailingIcon;
  final Color bubbleColor;
  final Widget? customContent;


  const CustomToastWidget({
    super.key,
    this.leadingIcon,
    required this.title,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    this.trailingIcon,
    required this.bubbleColor,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   // child: SvgPicture.asset(
          //   //   AppImages.greenBubbleIcon,
          //   //   color: bubbleColor,
          //   // ),
          // ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leadingIcon != null)
                  SvgPicture.asset(
                    leadingIcon ?? AppImages.successToastLeadIcon,
                    height: 35,
                    width: 35,
                  ),
                const SizedBox(width: 12),
                Expanded(
                    child: customContent ??
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: AppTextStyle.largeHeader.copyWith(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              message,
                              style: AppTextStyle.mediumHeader.copyWith(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                  ),

              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: textColor.withValues(alpha: 0.8),
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
