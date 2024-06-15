import 'package:app_test/modules/authentication/presenter/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/theme/app_collors.dart';

class OnboardingTwoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil.init(
      context,
      designSize: Size(width, height),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
        body: Column(
      children: [
        Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                  left: 20.w,
                  top: 190.h,
                  child: FlutterLogo(
                    size: 240.h,
                  )),
              Positioned(
                left: 20.w,
                top: 420.h,
                child: Text(
                  AppLocalizations.of(context)!.welcomeTo + '\n' + 'Full Stack',
                  style: TextStyle(
                    color: AppColors.primaryText(context),
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Positioned(
                left: 20.w,
                top: 523.h,
                child: Text(
                  'Flutter Nestjs ',
                  style: TextStyle(
                    color: AppColors.primaryText(context),
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Positioned(
                left: 28.w,
                top: 700.h,
                child: Container(
                  width: 16.w,
                  height: 6.h,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFFB6B6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 46.w,
                top: 700.h,
                child: Container(
                  width: 13.w,
                  height: 6.h,
                  decoration: ShapeDecoration(
                    color: AppColors.lightSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 320.w,
                top: 680.h,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AuthPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                left: 20.w,
                top: 246.h,
                child: Container(
                  width: 300.w,
                  height: 178.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}