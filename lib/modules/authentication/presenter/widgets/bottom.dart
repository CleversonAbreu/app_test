import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_collors.dart';

class Bottom extends StatelessWidget {
  final String title;
  final String textLink;
  final VoidCallback onPressed;
  const Bottom({
    super.key,
    required this.title,
    required this.textLink,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onPressed,
          child: RichText(
            text: TextSpan(
              text: title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryText(context),
              ),
              children: [
                TextSpan(
                  text: textLink,
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightSecondary),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
