// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import '../../extension/sized_box_extension.dart';
// import 'package:intl/intl.dart';

// class CustomDocumentWidget extends StatelessWidget {
//   final String title;
//   final String? fileName;
//   final VoidCallback onTap;
//   final VoidCallback? onDelete;

//   const CustomDocumentWidget({
//     super.key,
//     required this.title,
//     this.fileName,
//     required this.onTap,
//     this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     String currentDate = DateFormat('MMM dd').format(DateTime.now());

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF111112),
//             fontSize: 16,
//           ),
//         ),
//         10.height,
//         if (fileName != null && fileName!.isNotEmpty)
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             decoration: BoxDecoration(
//               color: const Color(0xFFF0F8FF), 
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: const Color(0xFFE2E8F0)),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   fileName!.toLowerCase().endsWith('.pdf') ? Icons.picture_as_pdf : Icons.image,
//                   color: const Color(0xFF0069C9),
//                   size: 28,
//                 ),
//                 12.width,
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         fileName!,
//                         style: const TextStyle(
//                           color: Color(0xFF111112),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       4.height,
//                       Text(
//                         '2.4 MB • Uploaded on $currentDate', 
//                         style: const TextStyle(
//                           color: Color(0xFF64748B),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 12.width,
//                 InkWell(
//                   onTap: onDelete,
//                   child: const Icon(
//                     Icons.delete_outline,
//                     color: Colors.red,
//                     size: 24,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         else
//           GestureDetector(
//             onTap: onTap,
//             child: DottedBorder(
//               color: const Color(0xFFCBD5E1),
//               strokeWidth: 1.5,
//               dashPattern: const [6, 4],
//               borderType: BorderType.RRect,
//               radius: const Radius.circular(12),
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF8FAFC),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   children: [
//                     const Icon(
//                       Icons.cloud_upload_outlined,
//                       color: Color(0xFF94A3B8),
//                       size: 32,
//                     ),
//                     8.height,
//                     const Text(
//                       'Upload Document',
//                       style: TextStyle(
//                         color: Color(0xFF0069C9),
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14,
//                       ),
//                     ),
//                     4.height,
//                     const Text(
//                       'png, jpeg, pdf, jpg',
//                       style: TextStyle(
//                         color: Color(0xFF94A3B8),
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
