import 'package:app_test/modules/auth/biometry/data/biometric_repository.dart';
import 'package:app_test/modules/auth/biometry/domain/usecases/biometric_usecase.dart';
import 'package:app_test/modules/settings/data/datasources/settings_datasource.dart';
import 'package:app_test/modules/settings/data/datasources/settings_datasource_impl.dart';

import 'package:app_test/modules/settings/data/repositories/settings_repository_impl.dart';
import 'package:app_test/modules/settings/domain/repositories/settings_repository.dart';
import 'package:app_test/modules/settings/domain/usecases/settings_usecase.dart';
import 'package:app_test/modules/settings/domain/usecases/settings_usecase_impl.dart';
import 'package:app_test/modules/settings/presenter/cubit/biometric_cubit.dart';
import 'package:app_test/modules/settings/presenter/cubit/language_cubit.dart';
import 'package:app_test/modules/settings/presenter/cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupSettingsDependencies() {
  // DataSource
  getIt.registerFactory<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl(getIt<SharedPreferences>()));

  // Repository
  getIt.registerFactory<SettingsRepository>(
      () => SettingsRepositoryImpl(getIt<SettingsLocalDataSource>()));

  // UseCase
  getIt.registerFactory<SettingsUseCase>(() =>
      SettingsUseCaseImpl(settingsRepository: getIt<SettingsRepository>()));

  // Cubit
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(getIt<SettingsUseCase>()));

  //  LanguageCubit
  getIt.registerFactory<LanguageCubit>(
      () => LanguageCubit(getIt<SettingsUseCase>()));

  //  BiometricUseCase
  getIt.registerFactory<BiometricUseCase>(
      () => BiometricUseCase(getIt<LocalAuthentication>()));

  //  BiometricRepository
  getIt.registerFactory<BiometricRepository>(
      () => BiometricRepository(getIt<BiometricUseCase>()));

  //  BiometricCubit
  getIt.registerFactory<BiometricCubit>(() => BiometricCubit(
      useCase: getIt<SettingsUseCase>(),
      biometricRepository: getIt<BiometricRepository>()));
}
