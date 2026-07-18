// Function to show a loading dialog
import 'package:flutter/material.dart';

import '../../constants/local_storage_key_strings.dart';
import 'app_lottie_loader.dart';

void showLoadingDialog() {
  showDialog(
      context: LocalStorageKeyStrings.appNavKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: AppLottieLoader());
      });
}

void hideLoadingDialog() {
  final navigator = Navigator.of(LocalStorageKeyStrings.appNavKey.currentContext!);

  if (navigator.canPop()) {
    navigator.pop();
  }
}

