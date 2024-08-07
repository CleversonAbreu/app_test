import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:app_test/core/constants/app_constants.dart';
import 'package:app_test/modules/common/presenter/widgets/logo.dart';
import 'package:app_test/modules/settings/presenter/cubit/theme_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_test/modules/common/presenter/widgets/bottom.dart';
import 'package:app_test/modules/common/presenter/widgets/custom_textfield.dart';
import 'package:app_test/modules/common/presenter/widgets/buttons/icon_button_loading.dart';
import 'package:app_test/modules/common/presenter/widgets/header.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/utils/validators/validator.dart';
import '../../../../service_locator.dart';
import '../../data/model/ottp_data_page_model.dart';
import '../cubit/otp_cubit.dart';

class OTPPage extends StatefulWidget {
  final OTPPageData data;

  const OTPPage({Key? key, required this.data}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final OTPCubit otpCubit;
  bool emailFieldVisible = true;
  bool otpFieldVisible = false;
  bool isLoading = false;
  late final String email;

  @override
  void initState() {
    super.initState();
    otpCubit = getIt<OTPCubit>();
  }

  void loading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  void validate(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      if (emailFieldVisible) {
        email = _emailController.text;
        otpCubit.sendOTPCode(_emailController.text);
      } else {
        otpCubit.verifyOTPCode(_otpController.text);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
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
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
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
                          title: emailFieldVisible
                              ? widget.data.title
                              : AppLocalizations.of(context)!.enterYourOtp,
                          subtitle: emailFieldVisible
                              ? widget.data.subtitle
                              : AppLocalizations.of(context)!
                                  .youReceivedOtpCodeEmail,
                        ),
                        SizedBox(height: 20.h),
                        BlocProvider(
                          create: (context) => otpCubit,
                          child: BlocListener<OTPCubit, OTPState>(
                            listener: (context, state) {
                              if (state is OTPLoading) {
                                loading();
                              } else if (state is OTPError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.message),
                                  ),
                                );
                                loading();
                              } else if (state is OTPSent) {
                                loading();
                                setState(() {
                                  emailFieldVisible = false;
                                  otpFieldVisible = true;
                                });
                              } else if (state is OTPVerified) {
                                loading();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        widget.data.nextPage(email),
                                  ),
                                );
                              } else if (state is OTPCodeError) {
                                loading();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(AppLocalizations.of(context)!
                                        .incorrectOTPCode),
                                  ),
                                );
                              }
                            },
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(height: 16.h),
                                  if (emailFieldVisible)
                                    CustomTextField(
                                      controller: _emailController,
                                      validator: (value) =>
                                          validateEmail(value, context),
                                      label: AppLocalizations.of(context)!
                                          .enterYourEmail,
                                      icon: const Icon(Icons.email),
                                    ),
                                  if (otpFieldVisible)
                                    CustomTextField(
                                      keyboardType: TextInputType.number,
                                      controller: _otpController,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (value) =>
                                          validateOtp(value, context),
                                      label: AppLocalizations.of(context)!
                                          .enterYourOtp,
                                      icon: const Icon(Icons.password),
                                    ),
                                  SizedBox(height: 16.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButtonLoading(
                          title: AppLocalizations.of(context)!.next,
                          icon: const Icon(Icons.arrow_forward_ios,
                              color: Colors.white, size: 18),
                          onPressed: () => validate(context),
                          isLoading: isLoading,
                        ),
                        SizedBox(height: 1.h),
                        Bottom(
                          title: AppLocalizations.of(context)!.alreadyMember,
                          textLink: AppLocalizations.of(context)!.logIn,
                          onPressed: () => GoRouter.of(context).go('/'),
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
