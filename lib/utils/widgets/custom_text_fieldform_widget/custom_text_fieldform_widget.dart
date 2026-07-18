import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/themes/app_text_style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final InputBorder? border;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final bool obscureText;
  final FocusNode? focusNode;
  final int? maxLines;
  final bool expands;
  final bool? readOnly;
  final String? hintText;
  final Color? hintTextColor;
  final VoidCallback? onTap;
  final int? maxLength;
  final bool lettersOnly;
  final bool removeBorder;
  final Color? textColor;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;

  const CustomTextField({
    super.key,
    this.border,
    this.controller,
    this.isPassword = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.autovalidateMode,
    this.obscureText = true,
    this.focusNode,
    this.maxLines = 1,
    this.expands = false,
    this.readOnly,
    this.hintText,
    this.hintTextColor,
    this.onTap,
    this.maxLength,
    this.lettersOnly = false,
    this.prefixIcon,
    this.removeBorder = false,
    this.textColor,
    this.fillColor,
    this.contentPadding,
    this.borderRadius,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final GlobalKey<FormFieldState<String>> _formFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_handleControllerChange);
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChange);
      widget.controller?.addListener(_handleControllerChange);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChange);
    super.dispose();
  }

  void _handleControllerChange() {
    if (_formFieldKey.currentState != null) {
      // Create a local variable for the current value to avoid race conditions
      final newValue = widget.controller?.text;
      // Only update if the value is different to avoid loops
      if (_formFieldKey.currentState!.value != newValue) {
        _formFieldKey.currentState!.didChange(newValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      key: _formFieldKey,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      initialValue: widget.controller?.text,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.fillColor ?? (widget.textColor != null 
                        ? Colors.white 
                        : AppColors.fromfildbgColor.withValues(alpha: 0.1)),
                    borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
                    border: Border.all(
                      color: state.hasError
                          ? Colors.red.withValues(alpha: 0.8)
                          : (widget.textColor != null ? Colors.black12 : Colors.white.withValues(alpha: 0.2)),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: widget.controller,
                    readOnly: widget.readOnly ?? false,
                    inputFormatters: [
                      if (widget.lettersOnly)
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z\u0900-\u097F ]'),
                        ),
                      if (widget.isPassword)
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
                      ...?widget.inputFormatters,
                    ],
                    onChanged: (value) {
                      state.didChange(value);
                      if (widget.onChanged != null) {
                        widget.onChanged!(value);
                      }
                    },
                    enableInteractiveSelection: !widget.isPassword,
                    contextMenuBuilder: widget.isPassword
                        ? (BuildContext context, EditableTextState editableTextState) {
                            return const SizedBox.shrink();
                          }
                        : null,
                    obscureText: widget.isPassword ? widget.obscureText : false,
                    keyboardType: widget.keyboardType,
                    style: AppTextStyle.mediumNormalText.copyWith(
                      color: widget.textColor ?? Colors.white.withValues(alpha: 0.9),
                      fontSize: 16,
                    ),
                    maxLines: widget.isPassword ? 1 : widget.maxLines,
                    expands: widget.expands,
                    focusNode: widget.focusNode,
                    maxLength: widget.maxLength,
                    decoration: InputDecoration(
                      filled: false,
                      hintText: widget.hintText ?? "",
                      hintStyle: AppTextStyle.mediumNormalText.copyWith(
                        color: widget.hintTextColor ??
                            (widget.textColor != null ? Colors.black38 : Colors.white.withValues(alpha: 0.6)),
                        fontSize: 14,
                      ),
                      isDense: widget.removeBorder ? true : false,
                      contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: widget.removeBorder ? 12 : 16,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      // Hide the internal error message
                      errorStyle: const TextStyle(height: 0, fontSize: 0),
                      suffixIcon: widget.suffixIcon != null
                          ? IconTheme(
                              data: IconThemeData(
                                color: widget.textColor?.withValues(alpha: 0.6) ?? Colors.white.withValues(alpha: 0.6),
                              ),
                              child: widget.suffixIcon!,
                            )
                          : null,
                      prefixIcon: widget.prefixIcon != null
                          ? IconTheme(
                              data: IconThemeData(
                                color: widget.textColor?.withValues(alpha: 0.6) ?? Colors.white.withValues(alpha: 0.6),
                              ),
                              child: widget.prefixIcon!,
                            )
                          : null,
                      counterText: "",
                    ),
                    onTap: widget.onTap,
                  ),
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Text(
                  state.errorText ?? "",
                  style: AppTextStyle.smallNormalText.copyWith(
                    color: Colors.red.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
