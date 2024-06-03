import 'package:app_test/core/theme/app_collors.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Link extends StatelessWidget {
  final String title;
  final String url;
  const Link({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          color: AppColors.lightSecondary,
        ),
      ),
    );
  }
}
