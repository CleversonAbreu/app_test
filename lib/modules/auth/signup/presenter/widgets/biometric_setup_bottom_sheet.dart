import 'package:flutter/material.dart';
import 'package:app_test/modules/auth/authentication/presenter/pages/auth_page.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../common/presenter/widgets/custom_bottom_sheet.dart';
import '../../../biometry/data/biometric_repository.dart';
import '../../../../common/presenter/pages/alert_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showBiometricSetupBottomSheet(
    BuildContext context, BiometricRepository biometricRepository) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    builder: (BuildContext context) {
      return CustomBottomSheet(
        onYesPressed: () async {
          // Checks if the device is capable of performing biometrics
          bool canCheck = await biometricRepository.checkBiometrics();
          if (canCheck) {
            List<BiometricType> listBiometrics =
                await biometricRepository.getAvailableBiometrics();
            //checks if the device has any biometrics registered
            if (listBiometrics.length > 0) {
              print('salvar preferencias');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => AlertPage(
                    alertType: AlertType.success,
                    title: AppLocalizations.of(context)!.biometricsEnabled,
                    text: AppLocalizations.of(context)!.tapSensorFinish,
                    biometricRepository: biometricRepository,
                  ),
                ),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => AlertPage(
                    alertType: AlertType.warning,
                    title: AppLocalizations.of(context)!.configureBiometrics,
                    text: AppLocalizations.of(context)!
                        .youNeedConfigureBiometrics,
                    biometricRepository: biometricRepository,
                  ),
                ),
              );
            }
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AlertPage(
                  alertType: AlertType.error,
                  title: AppLocalizations.of(context)!.errorBiometrics,
                  text:
                      AppLocalizations.of(context)!.deviceNotSupportBiometrics,
                  biometricRepository: biometricRepository,
                ),
              ),
            );
          }
        },
        onNoPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => AuthPage(),
            ),
          );
        },
      );
    },
  );
}
