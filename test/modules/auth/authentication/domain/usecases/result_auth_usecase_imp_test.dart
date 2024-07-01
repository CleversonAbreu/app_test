import 'package:app_test/modules/auth/authentication/domain/usecases/result_auth_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:app_test/modules/auth/authentication/domain/entities/result_auth_entity.dart';
import 'package:app_test/modules/auth/authentication/data/models/auth_model.dart';
import 'package:app_test/modules/auth/authentication/domain/errors/errors.dart';
import 'package:app_test/modules/auth/authentication/domain/repositories/auth_repository.dart';

import 'result_auth_usecase_imp_test.mocks.dart';

// Gera os mocks para AuthRepository
@GenerateMocks([AuthRepository])
void main() {
  late ResultAuthUsecaseImpl usecase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = ResultAuthUsecaseImpl(repository: mockRepository);
  });

  final authModel = AuthModel(email: 'test@test.com', password: '123456');

  test('Should return InvalidCredentials when email or password is empty',
      () async {
    // Executa o caso de uso com credenciais inválidas (vazias)
    final result = await usecase(AuthModel(email: '', password: ''));

    // Verifica se o resultado é uma instância de InvalidCredentials
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<InvalidCredentials>()),
      (_) => fail('Expected a Left with InvalidCredentials'),
    );
  });

  test('Should return ResultAuthEntity when auth is successful', () async {
    // Configura o mock para retornar Right(ResultAuthEntity(...))
    when(mockRepository.auth(authModel))
        .thenAnswer((_) async => Right(ResultAuthEntity(token: 'token')));

    // Executa o caso de uso com credenciais válidas
    final result = await usecase(authModel);

    // Verifica se o resultado é o esperado ResultAuthEntity
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected a Right with ResultAuthEntity'),
      (entity) => expect(entity, ResultAuthEntity(token: 'token')),
    );

    // Verifica se o método auth foi chamado no repositório com os argumentos corretos
    verify(mockRepository.auth(authModel));
  });

  test('Should return InvalidCredentials when auth fails', () async {
    // Configura o mock para retornar InvalidCredentials quando auth for chamado com authModel
    when(mockRepository.auth(authModel))
        .thenAnswer((_) async => Left(InvalidCredentials()));

    // Executa o caso de uso com credenciais válidas
    final result = await usecase(authModel);

    // Verifica se o resultado é uma instância de InvalidCredentials
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<InvalidCredentials>()),
      (_) => fail('Expected a Left with InvalidCredentials'),
    );

    // Verifica se o método auth foi chamado no repositório com os argumentos corretos
    verify(mockRepository.auth(authModel));
  });
}
