import 'package:flutter/material.dart';

import '../../constants/local_storage_key_strings.dart';

class CommonBottomSheet {
  static Future<T?> show<T>({
    required Widget body,
    bool isDismissible = true,
    bool enableDrag = true,
    BoxConstraints? constraints,
  }) {
    return showModalBottomSheet<T>(
      constraints: constraints,
      context: LocalStorageKeyStrings.appNavKey.currentContext!,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return body;
      },
    );
  }

  static void hideBottomSheet() {
    Navigator.pop(LocalStorageKeyStrings.appNavKey.currentContext!);
  }
}
