import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/app_colors.dart';


class AppLottieLoader extends StatelessWidget {
  const AppLottieLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: ColorFiltered(
        colorFilter:  ColorFilter.mode(
          AppColors.blue,
          BlendMode.srcIn,
        ),
        child: Lottie.asset(
          'assets/app_lottie_loader.json',
          repeat: true,
          reverse: true,
          animate: true,
            ),
      ),
    );
  }
}
