import 'package:app_test/core/constants/app_constants.dart';
import 'package:app_test/core/constants/app_routes.dart';
import 'package:app_test/core/constants/app_sizes.dart';
import 'package:app_test/modules/auth/change_password/presenter/cubit/change_password_cubit.dart';
import 'package:app_test/modules/auth/change_password/presenter/cubit/change_password_state.dart';
import 'package:app_test/modules/common/presenter/widgets/logo.dart';
import 'package:app_test/modules/settings/presenter/cubit/theme_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_test/l10n/localization.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/utils/validators/validator.dart';
import '../../../../common/presenter/widgets/bottom.dart';
import '../../../../common/presenter/widgets/custom_textfield.dart';
import '../../../../common/presenter/widgets/buttons/icon_button_loading.dart';
import '../../../../common/presenter/widgets/header.dart';

class ChangePasswordPage extends StatefulWidget {
  final String? email;
  const ChangePasswordPage({super.key, this.email});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email ?? '';
  }

  void loading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void validate(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      BlocProvider.of<ChangePasswordCubit>(context).changePassword(
        _emailController.text,
        _passwordController.text,
      );
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.s16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
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
                          title: AppLocalizations.of(context)!.enterYourNewPassword,
                          subtitle: AppLocalizations.of(context)!.enterYourNewAndConfirmationPassword,
                        ),
                        SizedBox(height: AppSizes.s20.h),
                        BlocListener<ChangePasswordCubit, ChangePasswordState>(
                          listener: (context, state) {
                            if (state is ChangePasswordLoadingState) {
                              loading();
                            } else if (state is ChangePasswordErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(AppLocalizations.of(context)!.unknownErrorOccurred,)),
                              );
                              loading();
                            } else if (state is ChangePasswordSuccessState) {
                              loading();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(AppLocalizations.of(context)!.passwordChangedSuccessfully)),
                              );
                              GoRouter.of(context).go(AppRoutes.auth);
                            }
                          },
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: _passwordController,
                                  validator: (value) => validatePassword(value, context),
                                  label: AppLocalizations.of(context)!.enterYourNewPassword,
                                  icon: const Icon(Icons.lock),
                                  obscureText: true,
                                ),
                                SizedBox(height: AppSizes.s16.h),
                                CustomTextField(
                                  controller: _confirmationPasswordController,
                                  validator: (value) => samePasswords(value, _passwordController, context),
                                  label: AppLocalizations.of(context)!.enterYourConfirmationPassword,
                                  icon: const Icon(Icons.lock),
                                  obscureText: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButtonLoading(
                          title: AppLocalizations.of(context)!.next,
                          icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                          onPressed: () => validate(context),
                          isLoading: isLoading,
                        ),
                        SizedBox(height: 1.h),
                        Bottom(
                          title: AppLocalizations.of(context)!.alreadyMember,
                          textLink: AppLocalizations.of(context)!.logIn,
                          onPressed: () => GoRouter.of(context).go(AppRoutes.auth),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
