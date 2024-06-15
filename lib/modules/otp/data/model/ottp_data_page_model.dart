import 'package:flutter/material.dart';

class OTPPageData {
  final String title;
  final String subtitle;
  final Widget Function(String) nextPage;

  OTPPageData({
    required this.title,
    required this.subtitle,
    required this.nextPage,
  });
}
