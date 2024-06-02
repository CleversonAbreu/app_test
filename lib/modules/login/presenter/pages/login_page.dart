import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/constants/app_constants.dart';
import '../widgets/bottom.dart';
import '../widgets/custom_check.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/default_btn.dart';
import '../widgets/header.dart';
import '../widgets/link.dart';
import '../widgets/logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100.h),
            const Logo(path: AppConstants.logo_path),
            SizedBox(height: 30.h),
            Header(
              title: AppLocalizations.of(context)!.welcomeBack,
              subtitle: AppLocalizations.of(context)!.signInToAccessYourAccount,
            ),
            SizedBox(height: 40.h),
            CustomTextField(
              label: AppLocalizations.of(context)!.enterYourEmail,
              icon: const Icon(Icons.email),
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              label: AppLocalizations.of(context)!.password,
              obscureText: true,
              icon: const Icon(Icons.lock),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                CustomCheck(title: AppLocalizations.of(context)!.rememberMe),
                const Spacer(),
                Link(
                  title: AppLocalizations.of(context)!.forgetPassword,
                  url: '',
                ),
              ],
            ),
            const Spacer(),
            DefaultBtn(
                title: AppLocalizations.of(context)!.next,
                icon: const Icon(Icons.arrow_forward_ios,
                    color: Colors.white, size: 18)),
            SizedBox(height: 20.h),
            Bottom(
                title: AppLocalizations.of(context)!.newMember,
                textLink: AppLocalizations.of(context)!.registerNow),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
