// import 'package:flutter/material.dart';

// import '../constants/local_storage_key_strings.dart';
// import '../widgets/custom_calendar_widget.dart';

// class CalendarHelper {
//   const CalendarHelper._();
//   static Future<DateTime?> showCustomCalendar({
//     required BuildContext context,
//     DateTime? initialDate,
//     DateTime? firstDate,
//     DateTime? lastDate,
//     String title = 'Select Date',
//   }) async {
//     DateTime? selectedDate;

//     await showModalBottomSheet(
//       context: LocalStorageKeyStrings.appNavKey.currentContext!,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: CustomCalendarWidget(
//           initialDate: initialDate,
//           firstDate: firstDate,
//           lastDate: lastDate,
//           title: title,
//           onDateSelected: (date) {
//             selectedDate = date;
//           },
//         ),
//       ),
//     );

//     return selectedDate;
//   }
// }
