import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:validators/validators.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../settings/presenter/cubit/theme_cubit.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/bottom.dart';
import '../widgets/custom_check.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/default_btn.dart';
import '../widgets/header.dart';
import '../widgets/link.dart';
import '../widgets/logo.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseInsertYourPassword;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseInsertYourEmail;
    } else if (!isEmail(value)) {
      return AppLocalizations.of(context)!.pleaseInsertValidEmail;
    }
    return null;
  }

  void validate(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      final password = _passwordController.text;
      ReadContext(context).read<AuthCubit>().auth(email, password);
    }
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

    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is AuthError) {
            String message = '';
            if (state.message == 'invalidCredentials') {
              message = AppLocalizations.of(context)!.invalidCredentials;
            } else {
              message = AppLocalizations.of(context)!.authError;
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100.h),
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
                      title: AppLocalizations.of(context)!.welcomeBack,
                      subtitle: AppLocalizations.of(context)!
                          .signInToAccessYourAccount,
                    ),
                    SizedBox(height: 40.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            validator: validateEmail,
                            label: AppLocalizations.of(context)!.enterYourEmail,
                            icon: const Icon(Icons.email),
                          ),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            controller: _passwordController,
                            validator: validatePassword,
                            label: AppLocalizations.of(context)!.password,
                            obscureText: true,
                            icon: const Icon(Icons.lock),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        CustomCheck(
                            title: AppLocalizations.of(context)!.rememberMe),
                        const Spacer(),
                        Link(
                          title: AppLocalizations.of(context)!.forgetPassword,
                          url: '',
                        ),
                      ],
                    ),
                    const Spacer(),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return DefaultBtn(
                          title: AppLocalizations.of(context)!.next,
                          icon: const Icon(Icons.arrow_forward_ios,
                              color: Colors.white, size: 18),
                          onPressed: () => validate(context),
                          isLoading: state is AuthLoading,
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Bottom(
                      title: AppLocalizations.of(context)!.newMember,
                      textLink: AppLocalizations.of(context)!.registerNow,
                    ),
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
