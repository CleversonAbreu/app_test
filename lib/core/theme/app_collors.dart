import 'package:flutter/material.dart';

class AppColors {
  static const Color lightPrimaryText = Color(0xFF252525);
  static const Color lightBackground = Colors.white;
  static const Color lightPrimary = Colors.blue;
  static const Color lightSecondary = Color(0xFFFF3951);

  static const Color darkPrimaryText = Color(0xFFE0E0E0);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkPrimary = Colors.blue;
  static const Color darkSecondary = Color(0xFFFF3951);

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
