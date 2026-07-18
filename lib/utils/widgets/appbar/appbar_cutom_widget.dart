import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../themes/app_text_style.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../../utils/extension/sized_box_extension.dart';

class AppbarCutomWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final double? titleFontSize;
  final bool isSearchActive;
  final bool showSearchIcon;
  final bool showFilterIcon;
  final bool hasFilter;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchToggle;
  final VoidCallback? onFilterTap;
  final String? hintText;
  final List<Widget>? actions;
  final Widget? leading;
  final double? leadingWidth;
  final Color? backgroundColor;

  const AppbarCutomWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.titleFontSize,
    this.isSearchActive = false,
    this.showSearchIcon = false,
    this.showFilterIcon = false,
    this.hasFilter = false,
    this.searchController,
    this.onSearchChanged,
    this.onSearchToggle,
    this.onFilterTap,
    this.hintText,
    this.actions,
    this.leading,
    this.leadingWidth,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading,
      centerTitle: false,
      leadingWidth: leadingWidth,
      backgroundColor: backgroundColor ?? AppColors.bgColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 16,
      title: isSearchActive
          ? Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.blueColor.withValues(alpha: 0.2),
                ),
              ),
              child: TextField(
                controller: searchController,
                autofocus: true,
                textAlignVertical: TextAlignVertical.center,
                onChanged: onSearchChanged,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%$-]')),
                ],
                decoration: InputDecoration(
                  hintText: hintText ?? 'Search...',
                  hintStyle: AppTextStyle.hintStyle.copyWith(
                    color: AppColors.dividerColor,
                    fontSize: 14,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      AppImages.searchicon,
                      colorFilter: const ColorFilter.mode(
                        AppColors.blueColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTextStyle.veryLargeHeader.copyWith(
                    fontSize:  18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null && subtitle!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle!,
                      style: AppTextStyle.smallNormalText.copyWith(
                        fontSize: 12,
                        color: AppColors.dividerColor,
                      ),
                    ),
                  ),
              ],
            ),
      actions: [
        if (showSearchIcon)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: onSearchToggle,
              child: Container(
                height: 36,
                width: 36,
                padding:  EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  isSearchActive ? AppImages.closeicon : AppImages.searchicon,
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.blueColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        if (showFilterIcon)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: onFilterTap,
              child: Container(
                height: 36,
                width: 36,
                padding:  EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.vectoricon,
                      height: 20,
                      width: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.blueColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    if (hasFilter)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 8,
                            minHeight: 8,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        if (actions != null) ...actions!,
        16.width,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}