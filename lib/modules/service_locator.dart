import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/user/profile/data/datasources/profile_remote_datasource.dart';
import 'package:app_test/modules/user/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:app_test/modules/user/profile/data/repositories/profile_repository_impl.dart';
import 'package:app_test/modules/user/profile/domain/repositories/profile_repository.dart';
import 'package:app_test/modules/user/profile/domain/usecases/get_profile_usecase.dart';
import 'package:app_test/modules/user/profile/domain/usecases/update_profile_usecase.dart';
import 'package:app_test/modules/user/profile/presenter/cubit/profile_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final flutterSecureStorage = FlutterSecureStorage();
  final localAuthentication = LocalAuthentication();

  //   SharedPreferences
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  //  FlutterSecureStorage
  getIt.registerSingleton<FlutterSecureStorage>(flutterSecureStorage);

  //  LocalAuthentication
  getIt.registerSingleton<LocalAuthentication>(localAuthentication);

  //  DioClient
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt<FlutterSecureStorage>()));

  //  Auth DataSource
  getIt.registerFactory<AuthDatasource>(() => AuthDataSourceImpl(getIt<DioClient>()));

  //  Auth Repository
  getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthDatasource>()));

  //  Token Repository
  getIt.registerFactory<TokenRepository>(() => TokenRepositoryImpl());

  // Registrar ResultAuthUsecase
  getIt.registerFactory<ResultAuthUsecase>(() => ResultAuthUsecaseImpl(repository: getIt<AuthRepository>()));

  //  AuthCubit
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<ResultAuthUsecase>(), getIt<TokenRepository>()));

  //  Settings Data Source
  getIt.registerFactory<SettingsLocalDataSource>(() => SettingsLocalDataSourceImpl(getIt<SharedPreferences>()));

  //  Settings Repository
  getIt.registerFactory<SettingsRepository>(() => SettingsRepositoryImpl(getIt<SettingsLocalDataSource>()));

  //  Settings UseCase
  getIt.registerFactory<SettingsUseCase>(() => SettingsUseCaseImpl(settingsRepository: getIt<SettingsRepository>()));

  //  ThemeCubit
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit(getIt<SettingsUseCase>()));

  //  LanguageCubit
  getIt.registerFactory<LanguageCubit>(() => LanguageCubit(getIt<SettingsUseCase>()));

  //  BiometricUseCase
  getIt.registerFactory<BiometricUseCase>(() => BiometricUseCase(getIt<LocalAuthentication>()));

  //  BiometricRepository
  getIt.registerFactory<BiometricRepository>(() => BiometricRepository(getIt<BiometricUseCase>()));

  //  BiometricCubit
  getIt.registerFactory<BiometricCubit>(() => BiometricCubit(useCase: getIt<SettingsUseCase>(), biometricRepository: getIt<BiometricRepository>()));

  // Config EmailOTP with preferences
  final EmailOTP emailOTP = EmailOTP();

  //  OTPRemoteDataSourceImpl using EmailOTP
  getIt.registerSingleton<OTPRemoteDataSource>(OTPRemoteDataSourceImpl(emailOTP));

  //  OTPRepositoryImpl using OTPRemoteDataSource
  getIt.registerSingleton<OTPRepository>(OTPRepositoryImpl(getIt<OTPRemoteDataSource>()));

  //  SendOTP using OTPRepository
  getIt.registerFactory<SendOTP>(() => SendOTP(getIt<OTPRepository>()));

  //  VerifyOTP using OTPRepository
  getIt.registerFactory<VerifyOTP>(() => VerifyOTP(getIt<OTPRepository>()));

  //  OTPCubit
  getIt.registerFactory<OTPCubit>(() => OTPCubit(
        sendOTP: getIt<SendOTP>(),
        verifyOTP: getIt<VerifyOTP>(),
      ));

// No seu service_locator.dart
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileRemoteDataSource>()),
  );

  // Registre o caso de uso do perfil
  getIt.registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(getIt<ProfileRepository>()));

  getIt.registerLazySingleton<UpdateProfileUseCase>(() => UpdateProfileUseCase(getIt<ProfileRepository>()));

  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getProfileUseCase: getIt<GetProfileUseCase>(), updateProfileUseCase: getIt<UpdateProfileUseCase>()),
  );

  // Registrar ProfileRemoteDataSource
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(getIt<DioClient>()),
  );
}
