import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheck extends StatelessWidget {
  final String title;
  const CustomCheck({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (value) {}),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF252525),
          ),
        )
      ],
    );
  }
}
