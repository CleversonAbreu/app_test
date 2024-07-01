// import 'package:app_test/modules/auth/biometry/domain/usecases/biometric_usecase.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:mockito/annotations.dart';

// // Anotação para gerar os mocks
// @GenerateMocks([BiometricUseCase, LocalAuthentication])
// void main() {}
// biometric_repository_test.dart

import 'package:app_test/modules/auth/biometry/data/biometric_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mockito/mockito.dart';

// Importe o arquivo de mocks gerado
import 'biometric_repository_test.mocks.dart';

void main() {
  late BiometricRepository repository;
  late MockBiometricUseCase mockBiometricUseCase;

  setUp(() {
    mockBiometricUseCase = MockBiometricUseCase();
    repository = BiometricRepository(mockBiometricUseCase);
  });

  test('Should call checkBiometrics on BiometricUseCase', () async {
    // Configuração do mock para o método checkBiometrics do BiometricUseCase
    when(mockBiometricUseCase.checkBiometrics()).thenAnswer((_) async => true);

    // Chama o método correspondente no repositório
    final result = await repository.checkBiometrics();

    // Verifica se o resultado é o esperado
    expect(result, true);

    // Verifica se o método foi chamado no mockBiometricUseCase
    verify(mockBiometricUseCase.checkBiometrics());
  });

  test('Should call getAvailableBiometrics on BiometricUseCase', () async {
    // Configuração do mock para o método getAvailableBiometrics do BiometricUseCase
    final biometricTypes = [BiometricType.face];
    when(mockBiometricUseCase.getAvailableBiometrics())
        .thenAnswer((_) async => biometricTypes);

    // Chama o método correspondente no repositório
    final result = await repository.getAvailableBiometrics();

    // Verifica se o resultado é o esperado
    expect(result, biometricTypes);

    // Verifica se o método foi chamado no mockBiometricUseCase
    verify(mockBiometricUseCase.getAvailableBiometrics());
  });
}
