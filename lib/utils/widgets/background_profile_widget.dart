import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';

class BackgroundProfileWidget extends StatelessWidget {
  final Widget headerWidget;
  final String backgroundImageUrl;
  final Widget bodyWidget;

  const BackgroundProfileWidget({
    super.key,
    required this.headerWidget,
    required this.backgroundImageUrl,
    required this.bodyWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Image.network(
            backgroundImageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppColors.backgroundColor,
                child: const Center(
                  child: Icon(Icons.broken_image, color: Colors.grey),
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: AppColors.backgroundColor,
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.parentBgColor),
                ),
              );
            },
          ),
        ),
        
        // Gradient Overlay
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.4),
                  AppColors.backgroundColor,
                ],
                stops: const [0.0, 1.0],
              ),
            ),
          ),
        ),

        SafeArea(
          child: Column(
            children: [
              headerWidget,
              Expanded(
                child: bodyWidget,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
