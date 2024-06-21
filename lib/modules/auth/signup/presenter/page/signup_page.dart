import 'package:app_test/core/constants/app_constants.dart';
import 'package:app_test/modules/common/presenter/widgets/logo.dart';
import 'package:app_test/modules/settings/presenter/cubit/theme_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../common/utils/validators/validator.dart';
import '../../../authentication/presenter/cubit/auth_cubit.dart';
import '../../../authentication/presenter/cubit/auth_state.dart';
import '../../../authentication/presenter/pages/auth_page.dart';
import '../../../../common/presenter/widgets/bottom.dart';
import '../../../../common/presenter/widgets/custom_textfield.dart';
import '../../../../common/presenter/widgets/default_btn.dart';
import '../../../../common/presenter/widgets/header.dart';
import '../../../biometry/data/biometric_repository.dart';
import '../../../biometry/domain/usecases/biometric_usecase.dart';
import '../widgets/biometric_setup_bottom_sheet.dart';

class SignUpPage extends StatefulWidget {
  final String email;
  const SignUpPage({super.key, required this.email});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _confirmationPasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  late AnimationController _controller;
  late final BiometricRepository biometricRepository;

  //mandar para futuro cubit
  void validate(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      _passwordController.clear();
      _confirmationPasswordController.clear();
      _fullNameController.clear();
      showBiometricSetupBottomSheet(context, biometricRepository);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    final localAuth = LocalAuthentication();
    final biometricUseCase = BiometricUseCase(localAuth);
    biometricRepository = BiometricRepository(biometricUseCase);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                  SizedBox(height: 30.h),
                  Header(
                    title: AppLocalizations.of(context)!.createAccount,
                    subtitle: AppLocalizations.of(context)!
                        .insertYourdataToCreateAccount,
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(height: 16.h),
                                CustomTextField(
                                  controller: _fullNameController,
                                  validator: (value) =>
                                      validateFullName(value, context),
                                  label: AppLocalizations.of(context)!
                                      .enterYourFullName,
                                  icon: const Icon(Icons.person),
                                ),
                                SizedBox(height: 16.h),
                                CustomTextField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  validator: (value) =>
                                      validatePassword(value, context),
                                  label: AppLocalizations.of(context)!
                                      .enterYourPassword,
                                  icon: const Icon(Icons.lock),
                                ),
                                SizedBox(height: 16.h),
                                CustomTextField(
                                  obscureText: true,
                                  controller: _confirmationPasswordController,
                                  validator: (value) => samePasswords(
                                      value, _passwordController, context),
                                  label: AppLocalizations.of(context)!
                                      .enterYourConfirmationPassword,
                                  icon: const Icon(Icons.lock),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
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
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AuthPage(),
                        ),
                      );
                    },
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
