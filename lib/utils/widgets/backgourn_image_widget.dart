import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackgroundImageWidget extends StatelessWidget {
  final String imagePath;
  final double mobileHeightFactor;
  final double webHeight; // Direct height in pixels or vh for web

  const BackgroundImageWidget({
    super.key,
    required this.imagePath,
    this.mobileHeightFactor = 0.5,
    this.webHeight = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    bool isWeb = screenWidth > 600;

    return SizedBox(
      width: double.infinity,
      height:
          isWeb ? screenHeight * webHeight : screenHeight * mobileHeightFactor,
      child: SvgPicture.asset(
        imagePath,
        fit: BoxFit.fill,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
