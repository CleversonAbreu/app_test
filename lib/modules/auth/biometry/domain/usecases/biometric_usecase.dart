import 'package:local_auth/local_auth.dart';

class BiometricUseCase {
  final LocalAuthentication auth;

  BiometricUseCase(this.auth);

  Future<bool> checkBiometrics() async {
    try {
      return await auth.canCheckBiometrics;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await auth.getAvailableBiometrics();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> authenticate() async {
    try {
      return await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> authenticateWithBiometrics() async {
    try {
      return await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> cancelAuthentication() async {
    await auth.stopAuthentication();
  }
}
