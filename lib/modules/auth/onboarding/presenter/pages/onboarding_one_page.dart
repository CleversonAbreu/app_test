import 'package:app_test/modules/auth/onboarding/presenter/pages/onboarding_standart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'onboarding_two_page.dart';

class OnboardingOnePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnboardingStandardPage(
      titleOne: AppLocalizations.of(context)!.welcomeTo,
      titleTwo: AppLocalizations.of(context)!.my + 'App Test',
      subtitle: 'Flutter Framework',
      numberPage: 1,
      child: OnboardingTwoPage(),
    );
  }
}
