import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_collors.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String text;
  final String? titleBtnLeft;
  final String? titleBtnRight;
  final VoidCallback? onPressedBtnLeft;
  final VoidCallback? onPressedBtnRight;
  final AlertType? alertType;

  const CustomAlert({
    Key? key,
    required this.title,
    required this.text,
    this.titleBtnLeft,
    this.titleBtnRight,
    this.onPressedBtnLeft,
    this.onPressedBtnRight,
    this.alertType,
  }) : super(key: key);

  IconData _getIconData(AlertType? alertType) {
    switch (alertType) {
      case AlertType.error:
        return Icons.error;
      case AlertType.warning:
        return Icons.warning;
      case AlertType.success:
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.lightBackground,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.black12,
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (alertType != null)
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.lightBackground,
              child: Icon(
                _getIconData(alertType),
                color: AppColors.darkBackground,
                size: 65.sp,
              ),
            ),
          SizedBox(height: 16.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 24.0),
          if (titleBtnLeft != null)
            ElevatedButton(
              onPressed: onPressedBtnLeft,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 24.0),
                child: Text(
                  titleBtnLeft!,
                  style: TextStyle(
                    color: AppColors.lightBackground,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          SizedBox(height: 16.0.h),
          if (titleBtnRight != null)
            TextButton(
              onPressed: onPressedBtnRight,
              child: Text(
                titleBtnRight!,
                style: TextStyle(
                  color: AppColors.darkBackground,
                  fontSize: 16.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
