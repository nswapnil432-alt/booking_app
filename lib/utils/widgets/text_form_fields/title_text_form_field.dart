import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../extension/sized_box_extension.dart';
import '../../constants/app_colors.dart';
import '../../themes/app_text_style.dart';

class TitleTextFormField extends StatelessWidget {
  final String? title;
  final bool? isStarTitleRequired;
  final bool? isOptional;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final Color? borderColor;
  final String? hintText;
  final void Function()? onTap;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? border;
  final bool? obscureText;
  final TextStyle? usertextStyle;
  final TextStyle? errorTextstyle;
  final bool? readOnly;
  final int? maxLines;
  final bool showCalenderIcon;
  final Color? hintTextColor;
  final TextStyle? titleStyle;
  final AutovalidateMode? autovalidateMode;
  final bool filled;
  final Color? fillColor;
  final bool showBorder;

  const TitleTextFormField({
    super.key,
    this.inputFormatters,
    this.validator,
    this.contentPadding,
    this.borderColor,
    this.hintText,
    this.onTap,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.obscureText,
    this.title,
    this.isStarTitleRequired = false,
    this.isOptional = false,
    this.usertextStyle,
    this.errorTextstyle,
    this.readOnly,
    this.maxLines,
    this.showCalenderIcon = false,
    this.hintTextColor,
    this.titleStyle,
    this.autovalidateMode,
    this.filled = false,
    this.fillColor,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    // Normal border (used for enabled, disabled, focused)
    final OutlineInputBorder normalBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: showBorder
          ? BorderSide(color: borderColor ?? AppColors.textGreyColor)
          : BorderSide.none,
    );

    // Error border
    final OutlineInputBorder redBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.redColor),
    );

    final InputDecoration inputDecoration = InputDecoration(
      filled: filled,
      fillColor: fillColor,
      contentPadding: contentPadding ?? const EdgeInsets.all(10.0),
      border: normalBorder,
      enabledBorder: normalBorder,
      disabledBorder: normalBorder,
      errorBorder: redBorder,
      focusedBorder: normalBorder, 
      focusedErrorBorder: redBorder,
      suffixIcon: showCalenderIcon
          ? IconButton(
              icon: const Icon(Icons.calendar_today, color: Colors.grey),
              onPressed: onTap,
            )
          : suffixIcon,
      prefixIcon: prefixIcon,
      hintText: hintText ?? "Write here...",
      hintStyle: AppTextStyle.hintStyle.copyWith(
        fontWeight: FontWeight.w400,
        color: hintTextColor ?? AppColors.textGreyColor,
      ),
      errorMaxLines: 1,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title ?? "",
              style: titleStyle ??
                  AppTextStyle.largeNormalText.copyWith(
                    color: AppColors.black,
                    fontSize: 14,
                  ),
            ),
            if (isStarTitleRequired ?? false)
              Text(
                " *",
                style: AppTextStyle.largeNormalText.copyWith(
                  color: AppColors.redColorDark,
                ),
              ),
            if (isOptional ?? false)
              Text(
                " (Optional)",
                style: AppTextStyle.mediumNormalText.copyWith(
                  color: AppColors.textGreyColor,
                ),
              ),
          ],
        ),
        8.height,
        TextFormField(
          readOnly: readOnly ?? false,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
          maxLines: maxLines ?? 1,
          inputFormatters: [
            ...(inputFormatters ?? [FilteringTextInputFormatter.deny(RegExp(r'^\s+'))]),
            if (obscureText == true)
              TextInputFormatter.withFunction((oldValue, newValue) {
                final int selectionLength = oldValue.selection.isValid 
                    ? (oldValue.selection.end - oldValue.selection.start).abs() 
                    : 0;
                final int insertedCount = newValue.text.length - (oldValue.text.length - selectionLength);
                if (insertedCount > 1) {
                  return oldValue; // Reject paste
                }
                return newValue;
              }),
          ],
          controller: controller,
          validator: validator,
          enableInteractiveSelection: !(obscureText ?? false),
          contextMenuBuilder: (obscureText ?? false)
              ? (BuildContext context, EditableTextState editableTextState) {
                  return const SizedBox.shrink();
                }
              : null,
          obscureText: obscureText ?? false,
          onTap: onTap,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: usertextStyle ??
              AppTextStyle.mediumHeader.copyWith(
                color: AppColors.black,
                fontSize: 14,
              ),
          decoration: inputDecoration,
        ),
      ],
    );
  }
}
