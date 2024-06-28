import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../common/presenter/widgets/header.dart';
import '../../../../common/presenter/widgets/logo.dart';
import '../../../../home/presenter/pages/home_page.dart';
import '../../../../settings/presenter/cubit/theme_cubit.dart';

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
        localizedReason:
            AppLocalizations.of(context)!.pleaseAuthenticateContinue,
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
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
      (Route<dynamic> route) => false,
    );
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
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, themeState) {
                        final logoPath = themeState == ThemeState.dark
                            ? AppConstants.logo_white_path
                            : AppConstants.logo_black_path;
                        return Logo(path: logoPath);
                      },
                    ),
                    SizedBox(height: 30.h),
                    Header(
                      title: AppLocalizations.of(context)!.yourSafestApp,
                      subtitle: AppLocalizations.of(context)!
                              .useYourPreferredAuthentication +
                          '\n' +
                          AppLocalizations.of(context)!.toContinueUsingApp,
                    ),
                    SizedBox(
                      height: 250.h,
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
