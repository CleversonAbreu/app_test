import 'package:app_test/core/dependencies/change_password_dependencies.dart';
import 'package:app_test/core/dependencies/otp_dependencies.dart';
import 'package:app_test/core/dependencies/settings_dependencies.dart';
import 'package:app_test/core/dependencies/signup_dependencies.dart';
import 'package:get_it/get_it.dart';
import 'package:app_test/core/dependencies/auth_dependencies.dart';
import 'package:app_test/core/dependencies/profile_dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:app_test/core/network/dio_client.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final flutterSecureStorage = FlutterSecureStorage();
  final localAuthentication = LocalAuthentication();

  // Serviços Globais
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerSingleton<FlutterSecureStorage>(flutterSecureStorage);
  getIt.registerSingleton<LocalAuthentication>(localAuthentication);

  // Cliente HTTP
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt<FlutterSecureStorage>()));

  // Módulos
  setupAuthDependencies();
  setupProfileDependencies();
  setupSettingsDependencies();
  setupSignUpDependencies();
  setupOtpDependencies();
  setupChangePasswordDependencies();
}
