import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_collors.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;
  const Header({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.primaryText(context),
            fontFamily: 'Mulish',
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
            color: AppColors.primaryText(context),
            fontFamily: 'Mulish',
          ),
        ),
      ],
    );
  }
}
