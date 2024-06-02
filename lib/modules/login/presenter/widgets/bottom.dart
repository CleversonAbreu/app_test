import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bottom extends StatelessWidget {
  final String title;
  final String textLink;
  const Bottom({
    super.key,
    required this.title,
    required this.textLink,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF252525),
          ),
          children: [
            TextSpan(
              text: textLink,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFF3951),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
