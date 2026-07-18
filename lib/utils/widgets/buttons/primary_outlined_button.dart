import 'package:flutter/material.dart';
import '../../themes/app_text_style.dart';
import '../../extension/sized_box_extension.dart';

import '../../constants/app_colors.dart';

class PrimaryOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? borderColor;
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

  const PrimaryOutlinedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.buttonColor,
    this.borderColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.height,
    this.width,
    this.fontSize,
    this.showIcon = false,
    this.icon,
    this.svgIconPath,
    this.svgIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: AppColors.textGrayColor,
          side: BorderSide(
            color: (onPressed != null)
                ? borderColor ?? Theme.of(context).primaryColor
                : borderColor?.withValues(alpha: 0.5) ??
                    Theme.of(context).primaryColor.withValues(alpha: 0.5),
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 4.0),
          ),
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon) ...[
              if (icon != null)
                Icon(
                  icon,
                  size: 20,
                  color: (onPressed != null)
                      ? textColor ?? Theme.of(context).primaryColor
                      : textColor?.withValues(alpha: 0.5) ??
                          Theme.of(context).primaryColor.withValues(alpha: 0.5),
                ),
              8.width,
            ],
            Text(
              label,
              style: AppTextStyle.alreadyAccountText.copyWith(
                color: (onPressed != null)
                    ? textColor ?? Theme.of(context).primaryColor
                    : textColor?.withValues(alpha: 0.5) ??
                        Theme.of(context).primaryColor.withValues(alpha: 0.5),
                fontSize: fontSize ?? 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
