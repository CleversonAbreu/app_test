import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_collors.dart';
import 'buttons/custom_elevated_button.dart';

class CustomBottomSheet extends StatefulWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onYesPressed;
  final VoidCallback? onNoPressed;
  final AlertType? alertType;

  CustomBottomSheet({
    required this.onYesPressed,
    this.onNoPressed,
    required this.title,
    this.subtitle,
    this.alertType,
  });

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  IconData _getIcon() {
    switch (widget.alertType) {
      case AlertType.success:
        return Icons.check;
      case AlertType.error:
        return Icons.error;
      case AlertType.warning:
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0).copyWith(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _animation,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.darkBackground,
              child: Icon(
                _getIcon(),
                size: 50,
                color: AppColors.lightBackground,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryText(context),
            ),
          ),
          SizedBox(height: 20),
          Text(
            widget.subtitle ?? '',
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomElevatedButton(
                onPressed: widget.onYesPressed,
                buttonText: AppLocalizations.of(context)!.ok,
              ),
              SizedBox(width: 20.w),
              if (widget.onNoPressed != null)
                ElevatedButton(
                  onPressed: widget.onNoPressed!,
                  child: Text(AppLocalizations.of(context)!.no),
                ),
            ],
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
