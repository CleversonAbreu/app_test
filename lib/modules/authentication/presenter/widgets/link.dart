import 'package:flutter/material.dart';
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
          color: const Color(0xFFFF3951),
        ),
      ),
    );
  }
}
