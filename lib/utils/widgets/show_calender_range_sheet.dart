import 'package:flutter/material.dart';
import '../constants/local_storage_key_strings.dart';
import '../constants/app_colors.dart';

class ShowCalenderRageSheet {
  static Future<void> showCalenderRangeBottomSheet({
    DateTime? startDate,
    DateTime? endDate,
    required Function(DateTime?, DateTime?) onDateRangeSelected,
  }) async {
    final context = LocalStorageKeyStrings.appNavKey.currentContext;
    if (context == null) return;
    
    final pickedDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: startDate != null && endDate != null
          ? DateTimeRange(start: startDate, end: endDate)
          : null,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.blueColor,
            scaffoldBackgroundColor: Colors.white,
            canvasColor: Colors.white,
            colorScheme: const ColorScheme.light(
              primary: AppColors.blueColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.black,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.black,
              elevation: 0,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              headerBackgroundColor: Colors.white,
              headerForegroundColor: AppColors.black,
              dayStyle: const TextStyle(fontWeight: FontWeight.bold),
              rangePickerHeaderBackgroundColor: Colors.white,
              rangePickerHeaderForegroundColor: AppColors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.blueColor,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (pickedDateRange != null) {
      onDateRangeSelected(pickedDateRange.start, pickedDateRange.end);
    } else {
      onDateRangeSelected(null, null);
    }
  }
}
