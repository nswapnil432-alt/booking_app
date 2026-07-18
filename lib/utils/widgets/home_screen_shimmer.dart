import 'package:flutter/material.dart';
import '../extension/sized_box_extension.dart';
import 'shimmer_widget.dart';

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          // Carousel Shimmer (Full width as per UI)
          const ShimmerWidget(
            width: double.infinity,
            height: 220,
            borderRadius: BorderRadius.zero,
          ),
          
          10.height,

          // Pagination Dots Shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ShimmerWidget(
                  width: index == 3 ? 24 : 8,
                  height: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),

          20.height,

          // Quick Actions Shimmer (Grid layout like the UI)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.0,
              children: List.generate(
                6,
                (index) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShimmerWidget(
                        width: 48,
                        height: 48,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      12.height,
                      ShimmerWidget(
                        width: 60,
                        height: 10,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          25.height,

          // Notices Shimmer Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerWidget(width: 80, height: 20, borderRadius: BorderRadius.circular(4)),
                    ShimmerWidget(width: 50, height: 14, borderRadius: BorderRadius.circular(4)),
                  ],
                ),
                15.height,
                ShimmerWidget(
                  width: double.infinity,
                  height: 160,
                  borderRadius: BorderRadius.circular(16),
                ),
              ],
            ),
          ),

          25.height,

          // Schemes Shimmer Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerWidget(width: 90, height: 20, borderRadius: BorderRadius.circular(4)),
                    ShimmerWidget(width: 50, height: 14, borderRadius: BorderRadius.circular(4)),
                  ],
                ),
                15.height,
                ShimmerWidget(
                  width: double.infinity,
                  height: 295,
                  borderRadius: BorderRadius.circular(16),
                ),
              ],
            ),
          ),

          40.height,
        ],
      ),
    );
  }
}
