import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:email_otp/email_otp.dart';

import 'package:app_test/modules/auth/authentication/data/datasources/auth_datasource.dart';
import 'package:app_test/modules/auth/authentication/data/datasources/auth_datasource_impl.dart';
import 'package:app_test/modules/auth/authentication/data/repositories/auth_repository_impl.dart';
import 'package:app_test/modules/auth/authentication/domain/repositories/auth_repository.dart';
import 'package:app_test/modules/auth/authentication/domain/repositories/token_repository.dart';
import 'package:app_test/modules/auth/authentication/domain/usecases/result_auth_usecase.dart';
import 'package:app_test/modules/auth/authentication/domain/usecases/result_auth_usecase_impl.dart';
import 'package:app_test/modules/auth/authentication/presenter/cubit/auth_cubit.dart';

import 'package:app_test/modules/settings/data/datasources/settings_datasource.dart';
import 'package:app_test/modules/settings/data/datasources/settings_datasource_impl.dart';
import 'package:app_test/modules/settings/data/repositories/settings_repository_impl.dart';
import 'package:app_test/modules/settings/domain/repositories/settings_repository.dart';
import 'package:app_test/modules/settings/domain/usecases/settings_usecase.dart';
import 'package:app_test/modules/settings/domain/usecases/settings_usecase_impl.dart';
import 'package:app_test/modules/settings/presenter/cubit/biometric_cubit.dart';
import 'package:app_test/modules/settings/presenter/cubit/language_cubit.dart';
import 'package:app_test/modules/settings/presenter/cubit/theme_cubit.dart';

import 'package:app_test/modules/auth/biometry/data/biometric_repository.dart';
import 'package:app_test/modules/auth/biometry/domain/usecases/biometric_usecase.dart';

import 'package:app_test/modules/auth/otp/data/datasources/otp_remote_datasource.dart';
import 'package:app_test/modules/auth/otp/data/datasources/otp_remote_datasource_impl.dart';
import 'package:app_test/modules/auth/otp/data/repositories/otp_repository_impl.dart';
import 'package:app_test/modules/auth/otp/domain/usecases/send_otp_usecase.dart';
import 'package:app_test/modules/auth/otp/domain/usecases/verify_otp_usecase.dart';
import 'package:app_test/modules/auth/otp/presenter/cubit/otp_cubit.dart';

import 'auth/authentication/data/repositories/token_repository_impl.dart';
import 'auth/otp/domain/repositories/otp_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final dio = Dio();
  final flutterSecureStorage = FlutterSecureStorage();
  final localAuthentication = LocalAuthentication();

  // Registrar SharedPreferences
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Registrar Dio
  getIt.registerSingleton<Dio>(dio);

  // Registrar FlutterSecureStorage
  getIt.registerSingleton<FlutterSecureStorage>(flutterSecureStorage);

  // Registrar LocalAuthentication
  getIt.registerSingleton<LocalAuthentication>(localAuthentication);

  // Registrar Auth Datasource
  getIt.registerFactory<AuthDatasource>(() => AuthDataSourceImpl(getIt<Dio>()));

  // Registrar Auth Repository
  getIt.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthDatasource>()));

  // Registrar Token Repository
  getIt.registerFactory<TokenRepository>(() => TokenRepositoryImpl());

  // Registrar ResultAuthUsecase
  getIt.registerFactory<ResultAuthUsecase>(
      () => ResultAuthUsecaseImpl(repository: getIt<AuthRepository>()));

  // Registrar AuthCubit
  getIt.registerFactory<AuthCubit>(
      () => AuthCubit(getIt<ResultAuthUsecase>(), getIt<TokenRepository>()));

  // Registrar Settings Data Source
  getIt.registerFactory<SettingsLocalDataSource>(
      () => SettingsLocalDataSourceImpl(getIt<SharedPreferences>()));

  // Registrar Settings Repository
  getIt.registerFactory<SettingsRepository>(
      () => SettingsRepositoryImpl(getIt<SettingsLocalDataSource>()));

  // Registrar Settings UseCase
  getIt.registerFactory<SettingsUseCase>(() =>
      SettingsUseCaseImpl(settingsRepository: getIt<SettingsRepository>()));

  // Registrar ThemeCubit
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(getIt<SettingsUseCase>()));

  // Registrar LanguageCubit
  getIt.registerFactory<LanguageCubit>(
      () => LanguageCubit(getIt<SettingsUseCase>()));

  // Registrar BiometricUseCase
  getIt.registerFactory<BiometricUseCase>(
      () => BiometricUseCase(getIt<LocalAuthentication>()));

  // Registrar BiometricRepository
  getIt.registerFactory<BiometricRepository>(
      () => BiometricRepository(getIt<BiometricUseCase>()));

  // Registrar BiometricCubit
  getIt.registerFactory<BiometricCubit>(() => BiometricCubit(
      useCase: getIt<SettingsUseCase>(),
      biometricRepository: getIt<BiometricRepository>()));

  // Configurar EmailOTP com suas preferências
  final EmailOTP emailOTP = EmailOTP();

  // Registrar OTPRemoteDataSourceImpl usando a instância configurada de EmailOTP
  getIt.registerSingleton<OTPRemoteDataSource>(
      OTPRemoteDataSourceImpl(emailOTP));

  // Registrar OTPRepositoryImpl usando a instância de OTPRemoteDataSource
  getIt.registerSingleton<OTPRepository>(
      OTPRepositoryImpl(getIt<OTPRemoteDataSource>()));

  // Registrar SendOTP usando a instância de OTPRepository
  getIt.registerFactory<SendOTP>(() => SendOTP(getIt<OTPRepository>()));

  // Registrar VerifyOTP usando a instância de OTPRepository
  getIt.registerFactory<VerifyOTP>(() => VerifyOTP(getIt<OTPRepository>()));

  // Registrar OTPCubit
  getIt.registerFactory<OTPCubit>(() => OTPCubit(
        sendOTP: getIt<SendOTP>(),
        verifyOTP: getIt<VerifyOTP>(),
      ));
}
