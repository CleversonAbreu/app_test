import 'package:app_test/core/theme/app_collors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheck extends StatelessWidget {
  final String title;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const CustomCheck({
    Key? key,
    required this.title,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.primaryText(context),
          ),
        ),
      ],
    );
  }
}
