import 'package:flutter/material.dart';

class PopularCategories extends StatelessWidget {
  final VoidCallback onCategoryTap;

  const PopularCategories({super.key, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "Popular categories",
            style: TextStyle(
              fontFamily: 'Serif',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D2E16),
            ),
          ),
        ),
        Row(
          children: [
            // Category 1: Vocalist
            Expanded(
              child: _buildCategoryCard(
                icon: Icons.mic_external_on_outlined,
                title: "Vocalist",
                description: "Solo and group vocal performers",
                onTap: onCategoryTap,
              ),
            ),
            const SizedBox(width: 16),
            // Category 2: Speaker
            Expanded(
              child: _buildCategoryCard(
                icon: Icons.settings_voice_outlined,
                title: "Speaker",
                description: "Storytellers and discourse hosts",
                onTap: onCategoryTap,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(color: const Color(0xFFEFE6DB), width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.01),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Box
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF2E8),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF5D2E16),
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Serif',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D2E16),
              ),
            ),
            const SizedBox(height: 6),
            // Description
            Text(
              description,
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
    );
  }
}
