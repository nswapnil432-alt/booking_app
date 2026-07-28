import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../login/view/login_screen.dart'; // To reuse DiyaWidget for Host category
import '../controller/services_controller.dart';
import '../model/services_model.dart';
import '../../../utils/navigation/app_routes.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller Initialize
    final ServicesController controller = Get.put(ServicesController());

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0), // Soft warm background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header Title
              const Text(
                "Services",
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D2E16),
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle
              const Text(
                "Choose a category to find trusted artists",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF8B7365),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              
              // Categories Grid
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFDE7322),
                      ),
                    );
                  }

                  if (controller.categories.isEmpty) {
                    return const Center(
                      child: Text("No categories found."),
                    );
                  }

                  return GridView.builder(
                    itemCount: controller.categories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85, // Ideal ratio for tall cards
                    ),
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return _buildCategoryCard(context, category);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, ServiceCategory category) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.serviceDetails, extra: category);
      },
      child: Container(
        clipBehavior: Clip.antiAlias, // Clips the decorative circle overflow
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(color: const Color(0xFFEFE6DB), width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      child: Stack(
        children: [
          // Decorative cream circle in the top right corner of the card
          Positioned(
            top: -24,
            right: -24,
            child: Container(
              width: 85,
              height: 85,
              decoration: const BoxDecoration(
                color: Color(0xFFFAF2E8),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          // Card Contents
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Box container
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF2E8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: category.isCustomDiya
                      ? const SizedBox(
                          width: 28,
                          height: 28,
                          child: FittedBox(
                            child: DiyaWidget(),
                          ),
                        )
                      : Icon(
                          category.icon,
                          color: const Color(0xFF5D2E16),
                          size: 28,
                        ),
                ),
                const Spacer(),
                // Title
                Text(
                  category.title,
                  style: const TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D2E16),
                  ),
                ),
                const SizedBox(height: 6),
                // Description
                Text(
                  category.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF8B7365),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
