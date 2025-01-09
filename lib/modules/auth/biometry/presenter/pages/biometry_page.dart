import 'package:app_test/core/constants/app_routes.dart';
import 'package:app_test/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../common/presenter/widgets/header.dart';
import '../../../../common/presenter/widgets/logo.dart';
import '../../../../settings/presenter/cubit/theme_cubit.dart';

const int kHeight = 250;

class BiometryPage extends StatefulWidget {
  const BiometryPage({Key? key}) : super(key: key);

  @override
  _BiometryPageState createState() => _BiometryPageState();
}

class _BiometryPageState extends State<BiometryPage> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _authenticate());
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: AppLocalizations.of(context)!.pleaseAuthenticateContinue,
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        _navigateToHomePage();
      } else {
        _authenticate();
      }
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  void _navigateToHomePage() {
    GoRouter.of(context).go(AppRoutes.home);
  }

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

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.s16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    SizedBox(height: AppSizes.spacingLarge),
                    BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, themeState) {
                        final logoPath = themeState == ThemeState.dark ? AppConstants.logo_white_path : AppConstants.logo_black_path;
                        return Logo(path: logoPath);
                      },
                    ),
                    SizedBox(height: AppSizes.s32.h),
                    Header(
                      title: AppLocalizations.of(context)!.yourSafestApp,
                      subtitle: AppLocalizations.of(context)!.useYourPreferredAuthentication + '\n' + AppLocalizations.of(context)!.toContinueUsingApp,
                    ),
                    SizedBox(
                      height: kHeight.h,
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
