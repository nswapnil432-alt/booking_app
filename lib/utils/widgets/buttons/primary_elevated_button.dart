import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../themes/app_text_style.dart';

class PrimaryElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final double? fontSize;
  final bool showIcon;
  final IconData? icon; 
  final String? svgIconPath; 
  final double? svgIconSize; 
  final Color? borderColor;
  final bool isLoading;

  const PrimaryElevatedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.buttonColor = AppColors.blueSkyColor,
    this.textColor = AppColors.white,
    this.borderRadius = 8.0,
    this.padding,
    this.height,
    this.width,
    this.fontSize = 16,
    this.showIcon = false,
    this.icon,
    this.svgIconPath,
    this.svgIconSize, 
    this.borderColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    return SizedBox(
      height: height ?? 48,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled
              ? Colors.grey.shade400
              : (buttonColor ?? Theme.of(context).primaryColor),
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
          padding: 
          padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: isLoading 
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: AppTextStyle.mediumNormalText.copyWith(
                      color: isDisabled ? Colors.white70 : textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (showIcon) ...[
                    const SizedBox(width: 8),
                    if (icon != null)
                      Icon(
                        icon,
                        size: 20,
                        color: textColor,
                      ),
                    if (svgIconPath != null)
                      SvgPicture.asset(
                        svgIconPath!,
                        height: svgIconSize, 
                        colorFilter: ColorFilter.mode(
                          textColor ?? AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                  ]
                ],
              ),
      ),
    );
  }
}
