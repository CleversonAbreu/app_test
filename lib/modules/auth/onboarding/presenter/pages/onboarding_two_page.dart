import 'package:app_test/modules/auth/onboarding/presenter/pages/onboarding_standart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../authentication/presenter/pages/auth_page.dart';

class OnboardingTwoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnboardingStandardPage(
      titleOne: AppLocalizations.of(context)!.opportunity,
      titleTwo: 'Full Stack',
      subtitle: 'Flutter Nestjs',
      numberPage: 2,
      child: AuthPage(),
    );
  }
}
