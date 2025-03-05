import 'package:app_test/core/constants/app_constants.dart';
import 'package:app_test/core/constants/app_routes.dart';
import 'package:app_test/core/constants/app_sizes.dart';
import 'package:app_test/core/theme/app_collors.dart';
import 'package:app_test/modules/auth/signup/data/models/signup_model.dart';
import 'package:app_test/modules/auth/signup/errors/signup_error.dart';
import 'package:app_test/modules/common/presenter/widgets/header.dart';
import 'package:app_test/modules/common/presenter/widgets/logo.dart';
import 'package:app_test/modules/settings/presenter/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../cubit/signup_cubit.dart';
import '../cubit/signup_state.dart';
import '../../../../common/utils/validators/validator.dart';
import '../../../../common/presenter/widgets/custom_textfield.dart';
import '../../../../common/presenter/widgets/buttons/icon_button_loading.dart';

class SignUpPage extends StatefulWidget {
  final String email;
  const SignUpPage({Key? key, required this.email}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
        body: BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(AppLocalizations.of(context)!.createAccountSuccess)),
          );
          GoRouter.of(context).go(AppRoutes.auth);
        } else if (state is SignUpFailure) {
          String message = _getErrorMessage(state.error, context);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      },
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.s20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSizes.spacingLarge),
                      BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, themeState) {
                          final logoPath = themeState == ThemeState.dark
                              ? AppConstants.logo_white_path
                              : AppConstants.logo_black_path;
                          return Logo(path: logoPath);
                        },
                      ),
                      SizedBox(height: AppSizes.s32.h),
                      Header(
                        title: AppLocalizations.of(context)!.createAccount,
                        subtitle: AppLocalizations.of(context)!
                            .enterYourNewAndConfirmationPassword,
                      ),
                      SizedBox(height: AppSizes.s40.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: _fullNameController,
                              validator: (value) =>
                                  validateFullName(value, context),
                              label: AppLocalizations.of(context)!
                                  .enterYourFullName,
                              icon: const Icon(Icons.email),
                            ),
                            SizedBox(height: AppSizes.s20.h),
                            CustomTextField(
                              controller: _passwordController,
                              validator: (value) =>
                                  validatePassword(value, context),
                              label: AppLocalizations.of(context)!.password,
                              obscureText: true,
                              icon: const Icon(Icons.lock),
                            ),
                            SizedBox(height: AppSizes.s20.h),
                            CustomTextField(
                              controller: _confirmPasswordController,
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return AppLocalizations.of(context)!
                                      .passwordsMustBeSame;
                                }
                                return null;
                              },
                              label: AppLocalizations.of(context)!
                                  .enterYourConfirmationPassword,
                              obscureText: true,
                              icon: const Icon(Icons.lock),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: AppSizes.s40.h), // Espaçamento antes do botão
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.s20.w, vertical: AppSizes.s12.h),
              child: SizedBox(
                height: 56.h,
                width: double.infinity, // Faz o botão ocupar toda a largura
                child: BlocBuilder<SignUpCubit, SignUpState>(
                  builder: (context, state) {
                    return IconButtonLoading(
                      title: AppLocalizations.of(context)!.next,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.lightBackground,
                        size: AppSizes.s16.h,
                      ),
                      onPressed: _onSignUpPressed,
                      isLoading: state is SignUpLoading,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  _onSignUpPressed() {
    if (_formKey.currentState!.validate()) {
      final signUpCubit = context.read<SignUpCubit>();
      final model = SignUpModel(
        email: widget.email,
        password: _passwordController.text.trim(),
        name: _fullNameController.text.trim(),
      );
      signUpCubit.registerUser(model);
    }
  }
}

String _getErrorMessage(SignUpError error, BuildContext context) {
  if (error.type == SignUpErrorType.timeoutError) {
    return AppLocalizations.of(context)!.requestTimedOut;
  } else {
    return AppLocalizations.of(context)!.unknownErrorOccurred;
  }
}
