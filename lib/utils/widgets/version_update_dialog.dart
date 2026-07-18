// import 'package:flutter/material.dart';
// import '../constants/app_colors.dart';
// import '../constants/app_images.dart';
// import '../extension/sized_box_extension.dart';
// import '../localiization/app_localizations.dart';
// import '../themes/app_text_style.dart';
// import 'package:url_launcher/url_launcher.dart';

// class VersionUpdateDialog extends StatelessWidget {
//   final bool forceUpdate;
//   final String storeUrl;
//   final VoidCallback? onSkip;

//   const VersionUpdateDialog({
//     super.key,
//     required this.forceUpdate,
//     required this.storeUrl,
//     this.onSkip,
//   });

//   Future<void> _launchStore() async {
//     final Uri url = Uri.parse(storeUrl);
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       throw Exception('Could not launch $url');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: !forceUpdate,
//       child: Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(24),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(24),
//           ),
//           child: Stack(
//             children: [
//               if (!forceUpdate)
//                 Positioned(
//                   right: 0,
//                   top: 0,
//                   child: GestureDetector(
//                     onTap: () {
//                       if (onSkip != null) {
//                         onSkip!();
//                       } else {
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     child: const Icon(
//                       Icons.close,
//                       color: Colors.black54,
//                       size: 28,
//                     ),
//                   ),
//                 ),
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Image.asset(
//                     AppImages.updatelogo,
//                     height: 120,
//                     width: 120,
//                     fit: BoxFit.contain,
//                   ),
//                   24.height,
//                   Text(
//                     AppLocalizations.of(context)!.updateAvailable,
//                     style: AppTextStyle.mediumNormalText.copyWith(
//                       fontSize: 32,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.primaryBlue,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   16.height,
//                   Text(
//                     AppLocalizations.of(context)!.updateDescription,
//                     style: AppTextStyle.mediumNormalText.copyWith(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black54,
//                       height: 1.4,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   32.height,
//                   Row(
//                     children: [
//                       if (!forceUpdate)
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 8.0),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 if (onSkip != null) {
//                                   onSkip!();
//                                 } else {
//                                   Navigator.of(context).pop();
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 elevation: 0,
//                                 backgroundColor: AppColors.primaryBlue
//                                     .withValues(alpha: 0.1),
//                                 foregroundColor: AppColors.primaryBlue,
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 16),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                               child: Text(
//                                 AppLocalizations.of(context)!.later,
//                                 style: AppTextStyle.mediumNormalText.copyWith(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.primaryBlue,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               left: !forceUpdate ? 8.0 : 0.0),
//                           child: ElevatedButton(
//                             onPressed: _launchStore,
//                             style: ElevatedButton.styleFrom(
//                               elevation: 0,
//                               backgroundColor: AppColors.primaryBlue,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Text(
//                               AppLocalizations.of(context)!.updateNow,
//                               style: AppTextStyle.mediumNormalText.copyWith(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
