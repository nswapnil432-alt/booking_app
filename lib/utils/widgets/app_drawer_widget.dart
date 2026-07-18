// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../constants/app_colors.dart';
// import '../constants/app_images.dart';
// import '../navigation/app_routes.dart';
// import '../themes/app_text_style.dart';
// import 'auth_storage_helper.dart';
// import '../networks/end_point.dart';
// // ignore: unused_import
// import '../extension/sized_box_extension.dart';

// class AppDrawerWidget extends StatefulWidget {
//   const AppDrawerWidget({super.key});

//   @override
//   State<AppDrawerWidget> createState() => _AppDrawerWidgetState();
// }

// class _AppDrawerWidgetState extends State<AppDrawerWidget>
//     with TickerProviderStateMixin {
//   bool _isCityExpanded = false;
//   bool _isVoterExpanded = false;

//   late final AnimationController _cityController;
//   late final AnimationController _voterController;

//   late final Animation<double> _cityAnimation;
//   late final Animation<double> _voterAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _cityController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 250),
//     );
//     _voterController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 250),
//     );

//     _cityAnimation = CurvedAnimation(
//       parent: _cityController,
//       curve: Curves.easeInOut,
//     );
//     _voterAnimation = CurvedAnimation(
//       parent: _voterController,
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void dispose() {
//     _cityController.dispose();
//     _voterController.dispose();
//     super.dispose();
//   }

//   void _toggleCity() {
//     setState(() => _isCityExpanded = !_isCityExpanded);
//     _isCityExpanded ? _cityController.forward() : _cityController.reverse();
//   }

//   void _toggleVoter() {
//     setState(() => _isVoterExpanded = !_isVoterExpanded);
//     _isVoterExpanded ? _voterController.forward() : _voterController.reverse();
//   }

//   void _closeAndNavigate(VoidCallback action) {
//     Navigator.of(context).pop(); // close drawer
//     Future.delayed(const Duration(milliseconds: 200), action);
//   }

//   @override
//   Widget build(BuildContext context) {
//     String? orgLogo = AuthStorageHelper.clientLogo;
//     if (orgLogo != null && orgLogo.isNotEmpty && !orgLogo.startsWith('http')) {
//       String path = orgLogo.startsWith('/') ? orgLogo.substring(1) : orgLogo;
//       orgLogo = "${EndPoint.s3BucketUrl}/$path";
//     }

//     final appRouter = GoRouter.of(context);

//     return Drawer(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       width: MediaQuery.of(context).size.width * 0.78,
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ── HEADER ──────────────────────────────────────────────
//             _buildHeader(orgLogo),

//             const SizedBox(height: 8),

//             // ── MENU ITEMS ───────────────────────────────────────────
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Home
//                     _buildMenuItem(
//                       icon: Icons.home_outlined,
//                       label: context.translateSafe('home', fallback: 'Home'),
//                       isActive: true,
//                       onTap: () => Navigator.of(context).pop(),
//                     ),

//                     const SizedBox(height: 4),

//                     // The City (expandable)
//                     _buildExpandableMenuItem(
//                       label: context.translateSafe('theCity', fallback: 'The City'),
//                       isExpanded: _isCityExpanded,
//                       onTap: _toggleCity,
//                       animation: _cityAnimation,
//                       children: [
//                         _buildSubMenuItem(
//                           icon: Icons.description_outlined,
//                           label: context.translateSafe('aboutKopargaon', fallback: 'About Kopargaon'),
//                           onTap: () => _closeAndNavigate(
//                             () => appRouter.push(AppRoutes.theCity, extra: 0),
//                           ),
//                         ),
//                         _buildSubMenuItem(
//                           icon: Icons.location_on_outlined,
//                           label: context.translateSafe('religiousSites', fallback: 'Religious Sites'),
//                           onTap: () => _closeAndNavigate(
//                             () => appRouter.push(AppRoutes.theCity, extra: 1),
//                           ),
//                         ),
//                         _buildSubMenuItem(
//                           icon: Icons.people_outline,
//                           label: context.translateSafe('demography', fallback: 'Demography'),
//                           onTap: () => _closeAndNavigate(
//                             () => appRouter.push(AppRoutes.theCity, extra: 2),
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 4),

//                     // Department
//                     _buildMenuItem(
//                       icon: Icons.account_balance_outlined,
//                       // label: 'Department',
//                       onTap: () => _closeAndNavigate(
//                         () => appRouter.push(AppRoutes.departmentMembers),
//                       ),
//                       label: context.translateSafe('department', fallback: 'Department'),
//                       // onTap: () => Navigator.of(context).pop(),
//                     ),

//                     const SizedBox(height: 4),

//                     // Download (expandable)
//                     // _buildExpandableMenuItem(
//                     //   label: 'Download',
//                     //   isExpanded: _isDownloadExpanded,
//                     //   onTap: _toggleDownload,
//                     //   animation: _downloadAnimation,
//                     //   children: [
//                     //     _buildSubMenuItem(
//                     //       icon: Icons.picture_as_pdf_outlined,
//                     //       label: 'Documents',
//                     //       onTap: () => Navigator.of(context).pop(),
//                     //     ),
//                     //     _buildSubMenuItem(
//                     //       icon: Icons.download_outlined,
//                     //       label: 'Forms',
//                     //       onTap: () => Navigator.of(context).pop(),
//                     //     ),
//                     //   ],
//                     // ),

//                     // const SizedBox(height: 4),

//                     // Gallery
//                     _buildMenuItem(
//                       icon: Icons.photo_library_outlined,
//                       label: context.translateSafe('gallery', fallback: 'Gallery'),
//                       onTap: () => _closeAndNavigate(
//                         () => appRouter.push(AppRoutes.gallery),
//                       ),
//                     ),

//                     const SizedBox(height: 4),

//                     // Voter Service (expandable)
//                     _buildExpandableMenuItem(
//                       label: context.translateSafe('voterService', fallback: 'Voter Service'),
//                       isExpanded: _isVoterExpanded,
//                       onTap: _toggleVoter,
//                       animation: _voterAnimation,
//                       children: [
//                         _buildSubMenuItem(
//                           icon: Icons.how_to_vote_outlined,
//                           label: context.translateSafe('voterRegistration', fallback: 'Voter Registration'),
//                           onTap: () => Navigator.of(context).pop(),
//                         ),
//                         _buildSubMenuItem(
//                           icon: Icons.search_outlined,
//                           label: context.translateSafe('searchVoter', fallback: 'Search Voter'),
//                           onTap: () => Navigator.of(context).pop(),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 4),

//                     // Contact Us
//                     // _buildMenuItem(
//                     //   icon: Icons.phone_outlined,
//                     //   label: 'Contact Us',
//                     //   onTap: () => _closeAndNavigate(
//                     //     () => appRouter.push(AppRoutes.clientdetails),
//                     //   ),
//                     // ),

//                     const SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//             ),

//             // ── FOOTER DIVIDER ───────────────────────────────────────
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Divider(color: Colors.grey.shade200, height: 1),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               child: Text(
//                 context.translateSafe('kopargaonMunicipalCouncil', fallback: 'Kopargaon Municipal Council'),
//                 style: AppTextStyle.hintStyle.copyWith(
//                   fontSize: 11,
//                   color: AppColors.textGreyColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ── HEADER ────────────────────────────────────────────────────────────
//   Widget _buildHeader(String? orgLogo) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           bottom: BorderSide(color: Colors.grey.shade100, width: 1),
//         ),
//       ),
//       child: Row(
//         children: [
//           // Logo circle
//           Container(
//             width: 52,
//             height: 52,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColors.bgGrayColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.08),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: ClipOval(
//               child: orgLogo != null && orgLogo.isNotEmpty
//                   ? CachedNetworkImage(
//                       imageUrl: orgLogo,
//                       fit: BoxFit.cover,
//                       placeholder: (_, __) =>
//                           Image.asset(AppImages.appLogo, fit: BoxFit.cover),
//                       errorWidget: (_, __, ___) =>
//                           Image.asset(AppImages.appLogo, fit: BoxFit.cover),
//                     )
//                   : Image.asset(AppImages.appLogo, fit: BoxFit.cover),
//             ),
//           ),
//           const SizedBox(width: 12),
//           // Text
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   context.translateSafe('kopargaon', fallback: 'Kopargaon'),
//                   style: AppTextStyle.hintStyle.copyWith(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.blueColor,
//                   ),
//                 ),
//                 Text(
//                   context.translateSafe('municipalCouncil', fallback: 'Municipal Council'),
//                   style: AppTextStyle.hintStyle.copyWith(
//                     fontSize: 12,
//                     color: AppColors.textGreyColor,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ── SIMPLE MENU ITEM ─────────────────────────────────────────────────
//   Widget _buildMenuItem({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//     bool isActive = false,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
//         decoration: BoxDecoration(
//           color: isActive
//               ? AppColors.blueColor.withValues(alpha: 0.08)
//               : Colors.transparent,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               size: 20,
//               color: isActive ? AppColors.blueColor : AppColors.greyTextColor,
//             ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Text(
//                 label,
//                 style: AppTextStyle.hintStyle.copyWith(
//                   fontSize: 14,
//                   fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
//                   color: isActive ? AppColors.blueColor : AppColors.blackColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ── EXPANDABLE MENU ITEM ──────────────────────────────────────────────
//   Widget _buildExpandableMenuItem({
//     required String label,
//     required bool isExpanded,
//     required VoidCallback onTap,
//     required Animation<double> animation,
//     required List<Widget> children,
//   }) {
//     return Column(
//       children: [
//         Material(
//           color: Colors.transparent,
//           borderRadius: BorderRadius.circular(10),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(10),
//             onTap: onTap,
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
//               decoration: BoxDecoration(
//                 color: isExpanded ? AppColors.bgColor : Colors.transparent,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.grid_view_rounded,
//                     size: 20,
//                     color: isExpanded
//                         ? AppColors.blueColor
//                         : AppColors.greyTextColor,
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: Text(
//                       label,
//                       style: AppTextStyle.hintStyle.copyWith(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: isExpanded
//                             ? AppColors.blueColor
//                             : AppColors.blackColor,
//                       ),
//                     ),
//                   ),
//                   AnimatedRotation(
//                     turns: isExpanded ? 0.5 : 0,
//                     duration: const Duration(milliseconds: 250),
//                     child: Icon(
//                       Icons.keyboard_arrow_down_rounded,
//                       size: 20,
//                       color: isExpanded
//                           ? AppColors.blueColor
//                           : AppColors.greyTextColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         ClipRect(
//           child: SizeTransition(
//             axis: Axis.vertical,
//             alignment: Alignment.topCenter,
//             sizeFactor: animation,
//             child: Container(
//               margin: const EdgeInsets.only(left: 10, right: 10, bottom: 4),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF0F6FF),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(children: children),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // ── SUB MENU ITEM ────────────────────────────────────────────────────
//   Widget _buildSubMenuItem({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Row(
//           children: [
//             const SizedBox(width: 4),
//             Icon(icon, size: 18, color: AppColors.greyTextColor),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 label,
//                 style: AppTextStyle.hintStyle.copyWith(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.blackColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
