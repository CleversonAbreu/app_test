// import 'package:mockito/annotations.dart';
// import 'package:local_auth/local_auth.dart';

// @GenerateMocks([LocalAuthentication])
// void main() {}

import 'package:app_test/modules/auth/biometry/domain/usecases/biometric_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:local_auth/local_auth.dart';

import 'biometric_usecase_test.mocks.dart';

@GenerateMocks([LocalAuthentication])
void main() {
  late BiometricUseCase biometricUseCase;
  late MockLocalAuthentication mockLocalAuthentication;

  setUp(() {
    mockLocalAuthentication = MockLocalAuthentication();
    biometricUseCase = BiometricUseCase(mockLocalAuthentication);
  });

  group('BiometricUseCase', () {
    test('checkBiometrics returns true when canCheckBiometrics is true',
        () async {
      when(mockLocalAuthentication.canCheckBiometrics)
          .thenAnswer((_) async => true);

      final result = await biometricUseCase.checkBiometrics();

      expect(result, true);
      verify(mockLocalAuthentication.canCheckBiometrics).called(1);
    });

    test(
        'checkBiometrics returns false when canCheckBiometrics throws an exception',
        () async {
      when(mockLocalAuthentication.canCheckBiometrics)
          .thenThrow(Exception('Error'));

      final result = await biometricUseCase.checkBiometrics();

      expect(result, false);
      verify(mockLocalAuthentication.canCheckBiometrics).called(1);
    });

    test('getAvailableBiometrics returns a list of biometrics', () async {
      final biometrics = [BiometricType.fingerprint];
      when(mockLocalAuthentication.getAvailableBiometrics())
          .thenAnswer((_) async => biometrics);

      final result = await biometricUseCase.getAvailableBiometrics();

      expect(result, biometrics);
      verify(mockLocalAuthentication.getAvailableBiometrics()).called(1);
    });

    test(
        'getAvailableBiometrics returns an empty list when an exception is thrown',
        () async {
      when(mockLocalAuthentication.getAvailableBiometrics())
          .thenThrow(Exception('Error'));

      final result = await biometricUseCase.getAvailableBiometrics();

      expect(result, []);
      verify(mockLocalAuthentication.getAvailableBiometrics()).called(1);
    });

    test('authenticate returns true when authentication is successful',
        () async {
      when(mockLocalAuthentication.authenticate(
              localizedReason: anyNamed('localizedReason'),
              options: anyNamed('options')))
          .thenAnswer((_) async => true);

      final result = await biometricUseCase.authenticate();

      expect(result, true);
      verify(mockLocalAuthentication.authenticate(
              localizedReason: anyNamed('localizedReason'),
              options: anyNamed('options')))
          .called(1);
    });

    test('authenticate returns false when an exception is thrown', () async {
      when(mockLocalAuthentication.authenticate(
              localizedReason: anyNamed('localizedReason'),
              options: anyNamed('options')))
          .thenThrow(Exception('Error'));

      final result = await biometricUseCase.authenticate();

      expect(result, false);
      verify(mockLocalAuthentication.authenticate(
              localizedReason: anyNamed('localizedReason'),
              options: anyNamed('options')))
          .called(1);
    });

    test(
        'authenticateWithBiometrics returns true when authentication is successful',
        () async {
      when(mockLocalAuthentication.authenticate(
              localizedReason: anyNamed('localizedReason'),
              options: anyNamed('options')))
          .thenAnswer((_) async => true);

      final result = await biometricUseCase.authenticateWithBiometrics();

      expect(result, true);
      verify(mockLocalAuthentication.authenticate(
              localizedReason: anyNamed('localizedReason'),
              options: anyNamed('options')))
          .called(1);
    });

    test('authenticateWithBiometrics returns false when an exception is thrown',
        () async {
      when(mockLocalAuthentication.authenticate(
              localizedReason: anyNamed('localizedReason'),
              options: anyNamed('options')))
          .thenThrow(Exception('Error'));

      final result = await biometricUseCase.authenticateWithBiometrics();

      expect(result, false);
      verify(mockLocalAuthentication.authenticate(
              localizedReason: anyNamed('localizedReason'),
              options: anyNamed('options')))
          .called(1);
    });

    test('cancelAuthentication calls stopAuthentication', () async {
      // Configura o mock para stopAuthentication
      when(mockLocalAuthentication.stopAuthentication())
          .thenAnswer((_) async => Future.value(true));

      await biometricUseCase.cancelAuthentication();

      verify(mockLocalAuthentication.stopAuthentication()).called(1);
    });
  });
}
