// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_collors.dart';
import '../../../../common/presenter/pages/custom_alert_page.dart';
import '../../../../settings/presenter/cubit/biometric_cubit.dart';
import '../../data/biometric_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BiometricSetupAlertPage extends StatelessWidget {
  final BiometricRepository biometricRepository;
  const BiometricSetupAlertPage({
    Key? key,
    required this.biometricRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomAlert(
          title: AppLocalizations.of(context)!.enableBiometrics,
          text: AppLocalizations.of(context)!.doYouWantEnableBiometrics,
          titleBtnLeft: AppLocalizations.of(context)!.yes,
          onPressedBtnLeft: () async {
            final String title;
            final String text;
            AlertType alertType;
            // Checks if the device is capable of performing biometrics
            bool canCheck = await biometricRepository.checkBiometrics();
            if (canCheck) {
              List<BiometricType> listBiometrics =
                  await biometricRepository.getAvailableBiometrics();
              //checks if the device has any biometrics registered
              if (listBiometrics.length > 0) {
                //enable biometry
                context.read<BiometricCubit>().enableBiometricPreference();

                title = AppLocalizations.of(context)!.biometricsEnabled;
                text = AppLocalizations.of(context)!.biometricEnabled;
                alertType = AlertType.success;
              } else {
                title = AppLocalizations.of(context)!.configureBiometrics;
                text = AppLocalizations.of(context)!.youNeedConfigureBiometrics;
                alertType = AlertType.warning;
              }
            } else {
              title = AppLocalizations.of(context)!.errorBiometrics;
              text = AppLocalizations.of(context)!.tapSensorFinish;
              alertType = AlertType.error;
            }

            final routeParams = {
              'alertType': alertType,
              'title': title,
              'text': text,
              'biometricRepository': biometricRepository,
            };

            GoRouter.of(context)
                .go('/biometryConfigAlertPage', extra: routeParams);
          },
          titleBtnRight: AppLocalizations.of(context)!.no,
          onPressedBtnRight: () => GoRouter.of(context).go('/auth'),
          alertType: AlertType.warning,
        ),
      ),
      backgroundColor: AppColors.lightGray,
    );
  }
}
