import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/authentication/presenter/cubit/auth_cubit.dart';
import '../../../auth/authentication/presenter/cubit/auth_state.dart';
import '../../../service_locator.dart';
import '../../domain/usecases/settings_usecase.dart';
import '../cubit/language_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../cubit/biometric_cubit.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../auth/biometry/data/biometric_repository.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();

    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.settingsTitle),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => GoRouter.of(context).go('/home'))),
      body: Column(
        children: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return ListTile(
                title: Text(AppLocalizations.of(context)!.darkMode),
                trailing: Switch(
                  value: themeState == ThemeState.dark,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),
              );
            },
          ),
          BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              return ListTile(
                title: Text(AppLocalizations.of(context)!.language),
                trailing: Switch(
                  value: locale == const Locale('pt', 'BR'),
                  onChanged: (value) {
                    context.read<LanguageCubit>().toggleLanguage();
                  },
                ),
              );
            },
          ),
          BlocProvider(
            create: (context) => BiometricCubit(
              useCase: getIt<SettingsUseCase>(),
              biometricRepository: getIt<BiometricRepository>(),
            ),
            child: BlocBuilder<BiometricCubit, bool?>(
              builder: (context, isEnabled) {
                return ListTile(
                  title: Text(AppLocalizations.of(context)!.biometry),
                  trailing: Switch(
                    value: isEnabled ?? false,
                    onChanged: (value) async {
                      context
                          .read<BiometricCubit>()
                          .toggleBiometricPreference();
                      final biometricRepository = getIt<BiometricRepository>();
                      final routeParams = {
                        'alertType': AlertType.warning,
                        'title':
                            AppLocalizations.of(context)!.configureBiometrics,
                        'text': AppLocalizations.of(context)!
                            .youNeedConfigureBiometrics,
                        'biometricRepository': biometricRepository,
                      };

                      if (value) {
                        if (await biometricRepository.checkBiometrics()) {
                          List<BiometricType> listBiometrics =
                              await biometricRepository
                                  .getAvailableBiometrics();
                          if (listBiometrics.isEmpty) {
                            GoRouter.of(context).go('/biometryConfigAlertPage',
                                extra: routeParams);
                          }
                        } else {
                          GoRouter.of(context).go('/biometryConfigAlertPage',
                              extra: routeParams);
                        }
                      }
                    },
                  ),
                );
              },
            ),
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              return ListTile(
                title: Text(AppLocalizations.of(context)!.logout),
                onTap: () async {
                  await storage.delete(key: 'token');
                  context.read<AuthCubit>().logout();
                  GoRouter.of(context).go('/auth');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
