import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoddingAnimationWidget extends StatelessWidget {
  const LoddingAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Lottie.asset(
            'assets/loading-bar.json',
            repeat: true,
            reverse: true,
            animate: true,
          ),
        ),
        //  Expanded(
        //   child: Lottie.asset(
        //       'assets/dotted-loader.json',
        //       height: 100,
        //       repeat: true,
        //       reverse: true,
        //       animate: true,
        //     ),
        // ),
      ],
    );
  }
}
