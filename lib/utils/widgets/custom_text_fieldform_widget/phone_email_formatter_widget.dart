import 'package:flutter/services.dart';

class PhoneOrEmailFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (RegExp(r'^[0-9]*$').hasMatch(text)) {
      if (text.length > 10) return oldValue;
    }

    return newValue;
  }
}
