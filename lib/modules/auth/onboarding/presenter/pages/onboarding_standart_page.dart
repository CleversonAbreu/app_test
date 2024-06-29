import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../../core/theme/app_collors.dart';

class OnboardingStandardPage extends StatelessWidget {
  final Widget child;
  final String titleOne;
  final String titleTwo;
  final String subtitle;
  final int numberPage;

  const OnboardingStandardPage({
    required this.child,
    required this.titleOne,
    required this.titleTwo,
    required this.subtitle,
    required this.numberPage,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360.w, 690.h),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
              child: Column(
                children: [
                  Spacer(flex: 3),
                  FlutterLogo(
                    size: 300.h,
                  ),
                  Spacer(flex: 2),
                  Text(
                    titleOne + '\n' + titleTwo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryText(context),
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryText(context),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Spacer(flex: 3),
                  _buildPageIndicator(numberPage),
                  Spacer(flex: 2),
                  CircleAvatar(
                    backgroundColor: AppColors.darkBackground,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.lightBackground,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: child,
                            duration: Duration(milliseconds: 350),
                          ),
                        );
                      },
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int numberPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (index) {
        bool isActive = index == numberPage - 1;
        return Container(
          width: isActive ? 16.w : 13.w,
          height: 6.h,
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: ShapeDecoration(
            color: isActive ? AppColors.lightSecondary : AppColors.teaRoseColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );
      }),
    );
  }
}
