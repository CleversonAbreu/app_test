import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:app_test/modules/auth/authentication/presenter/pages/auth_page.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../common/presenter/widgets/custom_bottom_sheet.dart';
import '../../../biometry/data/biometric_repository.dart';
import '../../../biometry/presenter/pages/biometric_setup_alert_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showSuccessSignUpBottomSheet(
    BuildContext context, BiometricRepository biometricRepository) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    enableDrag: false,
    builder: (BuildContext context) {
      return CustomBottomSheet(
        title: AppLocalizations.of(context)!.successfullyRegistered,
        alertType: AlertType.success,
        onYesPressed: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => BiometricSetupAlertPage(
                  biometricRepository: biometricRepository),
            ),
          );
        },
      );
    },
  );
}
