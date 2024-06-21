import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/theme/app_collors.dart';

class CustomBottomSheet extends StatefulWidget {
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;

  CustomBottomSheet({
    required this.onYesPressed,
    required this.onNoPressed,
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
      duration: const Duration(seconds: 10),
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
                Icons.check,
                size: 50,
                color: AppColors.lightBackground,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            AppLocalizations.of(context)!.registrationCompletedSuccessfully,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryText(context),
            ),
          ),
          SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.doYouWantEnableBiometrics,
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: widget.onYesPressed,
                child: Text(AppLocalizations.of(context)!.yes),
              ),
              SizedBox(width: 20.w),
              ElevatedButton(
                onPressed: widget.onNoPressed,
                child: Text(AppLocalizations.of(context)!.no),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
