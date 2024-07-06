// test/auth_repository_impl_test.dart
import 'package:app_test/modules/auth/authentication/data/models/result_auth_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:app_test/modules/auth/authentication/domain/errors/errors.dart';
import 'package:app_test/modules/auth/authentication/data/models/auth_model.dart';
import 'package:app_test/modules/auth/authentication/data/repositories/auth_repository_impl.dart';
import 'package:app_test/modules/auth/authentication/data/datasources/auth_datasource.dart';
import 'package:mockito/annotations.dart';

// Importe o arquivo gerado com os mocks
import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthDatasource])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockAuthDatasource();
    repository = AuthRepositoryImpl(mockDatasource);
  });

  final authModel = AuthModel(email: 'test@test.com', password: '123456');

  final resultAuthModel = ResultAuthModel(token: 'token');

  test(
      'Should return DataSourceError when datasource call throws DataSourceError',
      () async {
    // Configura o mock para lançar um DataSourceError
    when(mockDatasource.auth(authModel)).thenThrow(DataSourceError());

    // Executa o método auth do repositório com credenciais válidas
    final result = await repository.auth(authModel);

    // Verifica se o resultado é uma instância de DataSourceError
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<DataSourceError>()),
      (_) => fail('Expected a Left with DataSourceError'),
    );
  });

  test(
      'Should return DataSourceError with message when datasource call throws an unexpected error',
      () async {
    // Configura o mock para lançar um erro inesperado
    when(mockDatasource.auth(authModel))
        .thenThrow(Exception('Unexpected error'));

    // Executa o método auth do repositório com credenciais válidas
    final result = await repository.auth(authModel);

    // Verifica se o resultado é uma instância de DataSourceError com a mensagem esperada
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<DataSourceError>()),
      (_) => fail('Expected a Left with DataSourceError'),
    );

    result.fold(
      (failure) => failure is DataSourceError
          ? expect(failure.message, 'Exception: Unexpected error')
          : null,
      (_) => fail('Expected a Left with DataSourceError'),
    );
  });
  test('Should return ResultAuthModel when datasource call is successful',
      () async {
    // Configura o mock para retornar resultAuthModel quando auth for chamado com authModel
    when(mockDatasource.auth(authModel))
        .thenAnswer((_) async => resultAuthModel);

    // Executa o método auth do repositório com credenciais válidas
    final result = await repository.auth(authModel);

    // Verifica se o resultado é o esperado ResultAuthModel
    expect(result.isRight(), true);
    result.fold(
      (_) => fail('Expected a Right with ResultAuthModel'),
      (model) => expect(model, resultAuthModel),
    );

    // Verifica se o método auth foi chamado no datasource com os argumentos corretos
    verify(mockDatasource.auth(authModel));
  });
}
