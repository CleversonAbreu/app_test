import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:app_test/core/constants/app_constants.dart';
import 'package:app_test/modules/auth/authentication/domain/errors/errors.dart';
import 'package:app_test/modules/auth/authentication/data/models/auth_model.dart';
import 'package:app_test/modules/auth/authentication/data/models/result_auth_model.dart';
import 'package:app_test/modules/auth/authentication/data/datasources/auth_datasource_impl.dart';

import 'auth_datasource_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late AuthDataSourceImpl datasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    datasource = AuthDataSourceImpl(mockDio);
  });

  final authModel = AuthModel(email: 'test@test.com', password: '123456');
  final resultAuthModel = ResultAuthModel(token: 'token');

  test('Should return ResultAuthModel when the call to Dio is successful',
      () async {
    // Configura o mock para retornar uma resposta de sucesso
    when(mockDio.get('${AppConstants.url_base}/login'))
        .thenAnswer((_) async => Response(
              data: [
                {'token': 'token'}
              ],
              statusCode: 200,
              requestOptions:
                  RequestOptions(path: '${AppConstants.url_base}/login'),
            ));

    // Executa o método auth do datasource
    final result = await datasource.auth(authModel);

    // Verifica se o resultado é o esperado ResultAuthModel
    expect(result, resultAuthModel);
  });

  test('Should throw DataSourceError when the call to Dio is unsuccessful',
      () async {
    // Configura o mock para retornar uma resposta de erro
    when(mockDio.get('${AppConstants.url_base}/login'))
        .thenAnswer((_) async => Response(
              statusCode: 400,
              requestOptions:
                  RequestOptions(path: '${AppConstants.url_base}/login'),
            ));

    // Verifica se o método auth lança um DataSourceError
    expect(() async => await datasource.auth(authModel),
        throwsA(isA<DataSourceError>()));
  });

  test('Should rethrow the exception when an unexpected error occurs',
      () async {
    // Configura o mock para lançar uma exceção inesperada
    when(mockDio.get('${AppConstants.url_base}/login'))
        .thenThrow(Exception('Unexpected error'));

    // Verifica se o método auth lança a exceção inesperada
    expect(() async => await datasource.auth(authModel),
        throwsA(isA<Exception>()));
  });
}
