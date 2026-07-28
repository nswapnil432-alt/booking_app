import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../services/model/services_model.dart';
import '../controller/service_details_controller.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final ServiceCategory category;

  const ServiceDetailsScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    // Unique controller tag based on category title to avoid conflict
    final ServiceDetailsController controller = Get.put(
      ServiceDetailsController(categoryTitle: category.title),
      tag: category.title,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F0), // Soft warm background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Back Navigation Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: GestureDetector(
                onTap: () => context.pop(),
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: Color(0xFF5D2E16),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "All services",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5D2E16),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 2. Category Header Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28.0),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF8C2C0C), // Deep reddish-brown orange
                            Color(0xFFDE7322), // Vibrant orange
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tilted Category Icon
                          Transform.rotate(
                            angle: -0.4,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Icon(
                                category.icon,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Category Title
                          Text(
                            category.title,
                            style: const TextStyle(
                              fontFamily: 'Serif',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // Category Subtitle/Description
                          Text(
                            category.description,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 3. List of Artists
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.0),
                            child: CircularProgressIndicator(
                              color: Color(0xFFDE7322),
                            ),
                          ),
                        );
                      }

                      if (controller.artists.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.0),
                            child: Text(
                              "No artists found for this service.",
                              style: TextStyle(color: Color(0xFF8B7365)),
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.artists.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final artist = controller.artists[index];
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28.0),
                              border: Border.all(
                                color: const Color(0xFFEFE6DB),
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Artist Avatar Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    artist.imageUrl,
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      // Fail-safe fallback icon
                                      return Container(
                                        width: 75,
                                        height: 75,
                                        color: const Color(0xFFFAF2E8),
                                        child: const Icon(
                                          Icons.person,
                                          color: Color(0xFF5D2E16),
                                          size: 36,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                
                                // Artist Info Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Name
                                      Text(
                                        artist.name,
                                        style: const TextStyle(
                                          fontFamily: 'Serif',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF5D2E16),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      
                                      // Location & Exp
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.redAccent,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${artist.city} · ${artist.experienceYears} yrs",
                                            style: const TextStyle(
                                              color: Color(0xFF8B7365),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      
                                      // Rating
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xFFFFB300),
                                            size: 14,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${artist.rating} (${artist.ratingCount})",
                                            style: const TextStyle(
                                              color: Color(0xFF8B7365),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      
                                      // Pricing
                                      RichText(
                                        text: TextSpan(
                                          text: artist.pricePerEvent,
                                          style: const TextStyle(
                                            color: Color(0xFFD35515), // Orange price
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          children: const [
                                            TextSpan(
                                              text: " /event",
                                              style: TextStyle(
                                                color: Color(0xFF8B7365),
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
