import 'package:app_test/core/constants/app_constants.dart';
import 'package:app_test/modules/authentication/presenter/widgets/logo.dart';
import 'package:app_test/modules/settings/presenter/cubit/theme_cubit.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validators/validators.dart';
import '../../../authentication/presenter/cubit/auth_cubit.dart';
import '../../../authentication/presenter/cubit/auth_state.dart';
import '../../../authentication/presenter/widgets/bottom.dart';
import '../../../authentication/presenter/widgets/custom_textfield.dart';
import '../../../authentication/presenter/widgets/default_btn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  final maskFormatter = MaskTextInputFormatter(
    mask: '(##) ####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseInsertYourFullName;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseInsertYourPassword;
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseInsertYourPhoneNumber;
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
    if (_formKey.currentState?.validate() ?? false) {}
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
                  SizedBox(height: 20.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Form(
                              key: _formKey,
                              child: Column(children: [
                                CustomTextField(
                                  controller: _fullNameController,
                                  validator: validateFullName,
                                  label: AppLocalizations.of(context)!
                                      .enterYourFullName,
                                  icon: const Icon(Icons.person),
                                ),
                                SizedBox(height: 16.h),
                                CustomTextField(
                                  controller: _emailController,
                                  validator: validateEmail,
                                  label: AppLocalizations.of(context)!
                                      .enterYourEmail,
                                  icon: const Icon(Icons.email),
                                ),
                                SizedBox(height: 16.h),
                                CustomTextField(
                                  inputFormatters: [maskFormatter],
                                  controller: _phoneNumberController,
                                  keyboardType: TextInputType.phone,
                                  validator: validatePhoneNumber,
                                  label: AppLocalizations.of(context)!
                                      .enterYourPhoneNumber,
                                  icon: const Icon(Icons.phone),
                                ),
                                SizedBox(height: 16.h),
                                CustomTextField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  validator: validatePassword,
                                  label: AppLocalizations.of(context)!
                                      .enterYourPassword,
                                  icon: const Icon(Icons.lock),
                                ),
                              ])),
                          SizedBox(height: 16.h),
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .byCheckingBoxAgreeTerms,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
                  SizedBox(height: 1.h),
                  Bottom(
                    title: AppLocalizations.of(context)!.alreadyMember,
                    textLink: AppLocalizations.of(context)!.logIn,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
