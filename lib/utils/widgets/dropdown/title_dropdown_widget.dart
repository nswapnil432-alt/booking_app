// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import '../../extension/sized_box_extension.dart';
// import '../../constants/app_colors.dart';

// class TitleDropdownWidget extends StatelessWidget {
//   final String? title;
//   final TextStyle? textStyle;
//   final bool? isTitleRequired;
//   final List<String> items;
//   final String? hintText;
//   final String? selectedValue;
//   final void Function(String?)? onChanged;
//   final FormFieldValidator<String>? validator;
//   final AutovalidateMode? autovalidateMode;
//   final bool? isDropdownOnly;
//   final bool? isOptional;
//   final double? width;
//   final double? paddingLeft;
//   final bool? isDence;
//   final bool isIcon;
//   final bool showTitle;
//   final double? dropdownMaxHeight;
//   final bool isLoading;
//   final double? borderRadius;
//   final double? height;
//   final Color? fillColor;
//   final TextStyle? hintStyle;
//   final Color? borderColor;

//   const TitleDropdownWidget({
//     super.key,
//     this.title,
//     required this.items,
//     required this.selectedValue,
//     this.hintText,
//     this.onChanged,
//     this.textStyle,
//     this.isTitleRequired = false,
//     this.validator,
//     this.autovalidateMode,
//     this.isDropdownOnly = true,
//     this.isOptional = false,
//     this.width,
//     this.paddingLeft,
//     this.isDence,
//     this.isIcon = false,
//     this.showTitle = true,
//     this.dropdownMaxHeight,
//     this.isLoading = false,
//     this.borderRadius,
//     this.height,
//     this.fillColor,
//     this.hintStyle,
//     this.borderColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final textTheme = theme.textTheme;
//     final inputTheme = theme.inputDecorationTheme;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (isDropdownOnly ?? false)
//           Row(
//             children: [
//               if (showTitle)
//                 Text(title ?? "", style: textStyle ?? textTheme.bodyMedium),
//               2.width,
//               if (isTitleRequired ?? false)
//                 Text(
//                   "* ",
//                   style: (textStyle ?? textTheme.bodyMedium)?.copyWith(
//                     color: Colors.red,
//                   ),
//                 ),
//               2.width,
//               if (isOptional ?? false)
//                 Text(
//                   "(Optional)",
//                   style: (textStyle ?? textTheme.bodyMedium)?.copyWith(
//                     color: AppColors.hintTextColor,
//                   ),
//                 ),
//               5.width,
//               if (isIcon)
//                 Container(
//                   height: 15,
//                   width: 15,
//                   decoration: const BoxDecoration(
//                     color: AppColors.textGreyColor,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Center(
//                     child: Text("?",),
//                   ),
//                 ),
//             ],
//           ),
//         if (isDropdownOnly ?? false) const SizedBox(height: 5),

//         // Dropdown with validation
//         FormField<String>(
//           key: ValueKey(selectedValue),
//           initialValue: selectedValue,
//           autovalidateMode:
//               autovalidateMode ?? AutovalidateMode.onUserInteraction,
//           validator: validator,
//           builder: (FormFieldState<String> state) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 DropdownButtonHideUnderline(
//                   child: DropdownButton2<String>(
//                     isExpanded: true,
//                     isDense: isDence ?? false,
//                     hint: hintText != null
//                         ? Align(
//                             alignment: AlignmentDirectional.centerStart,
//                             child: Text(
//                               hintText!,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: hintStyle ?? inputTheme.hintStyle?.copyWith(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           )
//                         : null,
//                     items: items
//                         .map(
//                           (String item) {
//                             final hasSeparator = item.contains(':::');
//                             if (hasSeparator) {
//                               final parts = item.split(':::');
//                               final titlePart = parts.first;
//                               final codePart = parts.last;

//                               return DropdownItem<String>(
//                                 value: item,
//                                 child: Row(
//                                   children: [
//                                     Flexible(
//                                       child: Text(
//                                         titlePart,
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: textTheme.bodyLarge?.copyWith(
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                     ),
//                                     Text(
//                                       ' - $codePart',
//                                       style: textTheme.bodyLarge?.copyWith(
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }

//                             return DropdownItem<String>(
//                               value: item,
//                               child: Text(
//                                 item,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: textTheme.bodyLarge?.copyWith(
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             );
//                           },
//                         )
//                         .toList(),
//                     value:
//                         (selectedValue != null &&
//                             items.isNotEmpty &&
//                             items.contains(selectedValue))
//                         ? selectedValue
//                         : null,
//                     onChanged: (newValue) {
//                       onChanged?.call(newValue);
//                       state.didChange(newValue);
//                     },
//                     buttonStyleData: ButtonStyleData(
//                       height: height,
//                       width: width,
//                       padding: EdgeInsets.only(
//                         left: paddingLeft ?? 0,
//                         right: 14,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(borderRadius ?? 6),
//                         border: Border.all(
//                           color: state.hasError
//                               ? AppColors.redColor
//                               // lightGreyColor
                              
//                               : (borderColor ?? AppColors.lightGreyColor),
//                         ),
//                         color: fillColor ?? (theme.brightness == Brightness.dark
//                             ? Colors.black
//                             : AppColors.white),
//                       ),
//                       elevation: 0,
//                     ),
//                     iconStyleData: IconStyleData(
//                       iconEnabledColor: theme.brightness == Brightness.dark
//                           ? Colors.white
//                           : Colors.black,
//                       iconSize: 18,
//                       icon: isLoading
//                           ? SizedBox(
//                               width: 18,
//                               height: 18,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation(
//                                   theme.brightness == Brightness.dark
//                                       ? Colors.white
//                                       : Colors.black,
//                                 ),
//                               ),
//                             )
//                           // : SvgPicture.asset(
//                           //     AppImagesIconsArrows.dropDown,
//                           //     colorFilter: ColorFilter.mode(
//                           //       theme.brightness == Brightness.dark
//                           //           ? Colors.white
//                           //           : Colors.black,
//                           //       BlendMode.srcIn,
//                           //     ),
//                           //   ),
//                           :Icon(Icons.keyboard_arrow_down),
//                     ),
//                     alignment: AlignmentDirectional.center,
//                     dropdownStyleData: DropdownStyleData(
//                       maxHeight: dropdownMaxHeight ?? 200,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(borderRadius ?? 8),
//                         color: fillColor ?? (theme.brightness == Brightness.dark
//                             ? Colors.black
//                             : AppColors.white),
//                       ),
//                       offset: const Offset(0, 6),
//                       scrollbarTheme: ScrollbarThemeData(
//                         thickness: WidgetStateProperty.all(4),
//                         radius: const Radius.circular(10),
//                         thumbVisibility: WidgetStateProperty.all(true),
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (state.hasError)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 5, left: 16),
//                     child: Row(
//                       children: [
//                         // SvgPicture.asset(
//                         //   AppImagesIconsActions.help,
//                         //   width: 14,
//                         //   height: 14,
//                         //   colorFilter: const ColorFilter.mode(
//                         //     Colors.red,
//                         //     BlendMode.srcIn,
//                         //   ),
//                         // ),
//                         // const SizedBox(width: 6),
//                         Expanded(
//                           child: Text(
//                             state.errorText!,
//                             // state.errorText ?? "Error",
//                             style: TextStyle(
//                               color: theme.colorScheme.error,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
