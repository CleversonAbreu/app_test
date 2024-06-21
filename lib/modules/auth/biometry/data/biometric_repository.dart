import 'package:local_auth/local_auth.dart';

import '../domain/usecases/biometric_usecase.dart';

class BiometricRepository {
  final BiometricUseCase biometricUseCase;

  BiometricRepository(this.biometricUseCase);

  Future<bool> checkBiometrics() async {
    return await biometricUseCase.checkBiometrics();
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await biometricUseCase.getAvailableBiometrics();
  }

  Future<bool> authenticate() async {
    return await biometricUseCase.authenticate();
  }

  Future<bool> authenticateWithBiometrics() async {
    return await biometricUseCase.authenticateWithBiometrics();
  }

  Future<void> cancelAuthentication() async {
    await biometricUseCase.cancelAuthentication();
  }
}
