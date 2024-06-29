import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../auth/authentication/presenter/cubit/auth_cubit.dart';
import '../../../auth/authentication/presenter/cubit/auth_state.dart';
import '../../../auth/biometry/data/biometric_repository.dart';
import '../../../auth/biometry/domain/usecases/biometric_usecase.dart';
import '../../../auth/biometry/presenter/pages/biometry_config_alert_page.dart';
import '../../data/repositories/settings_repository.dart';
import '../../domain/get_biometric_preference.dart';
import '../../domain/save_biometric_preference.dart';
import '../cubit/language_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../cubit/biometric_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();

    final settingsRepository = SettingsRepository();
    final saveBiometricPreference = SaveBiometricPreference(settingsRepository);
    final getBiometricPreference = GetBiometricPreference(settingsRepository);
    final localAuth = LocalAuthentication();
    final biometricUseCase = BiometricUseCase(localAuth);
    final biometricRepository = BiometricRepository(biometricUseCase);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
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
              saveBiometricPreference: saveBiometricPreference,
              getBiometricPreference: getBiometricPreference,
              biometricRepository: biometricRepository,
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
                      if (value) {
                        if (await biometricRepository.checkBiometrics()) {
                          List<BiometricType> listBiometrics =
                              await biometricRepository
                                  .getAvailableBiometrics();

                          if (listBiometrics.length == 0) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => BiometryConfigAlertPage(
                                  alertType: AlertType.warning,
                                  title: AppLocalizations.of(context)!
                                      .configureBiometrics,
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
                              builder: (context) => BiometryConfigAlertPage(
                                alertType: AlertType.warning,
                                title: AppLocalizations.of(context)!
                                    .configureBiometrics,
                                text: AppLocalizations.of(context)!
                                    .youNeedConfigureBiometrics,
                                biometricRepository: biometricRepository,
                              ),
                            ),
                          );
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
                  // ignore: use_build_context_synchronously
                  context.read<AuthCubit>().logout();
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, '/auth');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
