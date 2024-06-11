import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_collors.dart';

class CustomCheck extends StatefulWidget {
  final String title;

  const CustomCheck({
    super.key,
    required this.title,
  });

  @override
  State<CustomCheck> createState() => _CustomCheckState();
}

class _CustomCheckState extends State<CustomCheck> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.primaryText(context),
          ),
        ),
      ],
    );
  }
}
