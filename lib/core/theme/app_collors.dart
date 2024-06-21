import 'package:flutter/material.dart';

class AppColors {
  static const Color lightPrimaryText = Color(0xFF252525);
  static const Color lightBackground = Colors.white;
  static const Color lightPrimary = Color(0xFF2196F3);
  static const Color lightSecondary = Color(0xFFFF3951);

  static const Color darkPrimaryText = Color.fromRGBO(224, 224, 224, 1);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkPrimary = Color(0xFF2196F3);
  static const Color darkSecondary = Color(0xFFFF3951);

  static const Color greenColor = Color(0xFF4CAF50);
  static const Color teaRoseColor = Color(0xFFFFB6B6);

  static const Color lightGray = Color(0xFF696969);

  static const Color black12 = Color(0x1F000000);

  static Color primaryText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkPrimaryText
        : lightPrimaryText;
  }

  static Color background(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackground
        : lightBackground;
  }

  static Color primary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkPrimary
        : lightPrimary;
  }
}
