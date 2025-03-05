import 'package:app_test/modules/auth/biometry/data/biometric_repository.dart';
import 'package:app_test/modules/auth/biometry/domain/usecases/biometric_usecase.dart';
import 'package:app_test/modules/settings/domain/usecases/settings_usecase.dart';
import 'package:app_test/modules/settings/presenter/cubit/biometric_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

final getIt = GetIt.instance;

void setupBiometricDependencies() {
  //  BiometricUseCase
  getIt.registerFactory<BiometricUseCase>(() => BiometricUseCase(getIt<LocalAuthentication>()));

  //  BiometricRepository
  getIt.registerFactory<BiometricRepository>(() => BiometricRepository(getIt<BiometricUseCase>()));

  //  BiometricCubit
  getIt.registerFactory<BiometricCubit>(() => BiometricCubit(useCase: getIt<SettingsUseCase>(), biometricRepository: getIt<BiometricRepository>()));
}