import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:app_test/modules/auth/authentication/presenter/pages/auth_page.dart';
import 'package:app_test/modules/home/presenter/pages/home_page.dart';
import 'package:app_test/modules/auth/biometry/presenter/pages/biometry_page.dart';
import 'package:app_test/modules/auth/onboarding/presenter/pages/onboarding_one_page.dart';
import 'package:app_test/modules/settings/presenter/pages/settings_page.dart';
import 'package:app_test/modules/auth/biometry/presenter/pages/biometric_setup_alert_page.dart';
import 'package:app_test/modules/auth/biometry/presenter/pages/biometry_config_alert_page.dart';
import 'package:app_test/modules/auth/otp/presenter/pages/otp_page.dart';
import 'package:app_test/modules/auth/otp/data/model/ottp_data_page_model.dart';
import 'package:app_test/modules/auth/biometry/data/biometric_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/app_constants.dart';
import 'settings/data/datasources/settings_datasource_impl.dart';
import 'settings/data/repositories/settings_repository_impl.dart';
import 'settings/domain/repositories/settings_repository.dart';

class AppRouter {
  final FlutterSecureStorage _secureStorage;
  late final GoRouter _router;

  AppRouter(this._secureStorage);

  Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final settingsLocalDataSource =
        SettingsLocalDataSourceImpl(sharedPreferences);
    final settingsRepository = SettingsRepositoryImpl(settingsLocalDataSource);

    final useBiometrics =
        await settingsRepository.getBiometricPreference() ?? false;

    //token
    final token = await _secureStorage.read(key: 'token');

    _router = GoRouter(
      initialLocation:
          token != null ? (useBiometrics ? '/biometry' : '/home') : '/auth',
      routes: [
        GoRoute(
          path: '/auth',
          builder: (context, state) => const AuthPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/biometry',
          builder: (context, state) => BiometryPage(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => OnboardingOnePage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: '/otpPage',
          builder: (context, state) {
            final params = state.extra as Map<String, dynamic>;
            return OTPPage(
              data: OTPPageData(
                title: params['title'] as String,
                subtitle: params['subtitle'] as String,
                nextPage: (email) => params['nextPage'](email) as Widget,
              ),
            );
          },
        ),
        GoRoute(
          path: '/biometryConfigAlertPage',
          builder: (context, state) {
            final params = state.extra as Map<String, dynamic>;
            return BiometryConfigAlertPage(
              alertType: params['alertType'] as AlertType,
              title: params['title'] as String,
              text: params['text'] as String,
              biometricRepository:
                  params['biometricRepository'] as BiometricRepository,
            );
          },
        ),
        GoRoute(
          path: '/biometricSetupAlertPage',
          builder: (context, state) {
            final params = state.extra as Map<String, dynamic>;
            return BiometricSetupAlertPage(
              biometricRepository:
                  params['biometricRepository'] as BiometricRepository,
            );
          },
        ),
      ],
    );
  }

  GoRouter get router => _router;
}
