import 'package:app_test/modules/authentication/data/datasources/auth_datasource.dart';
import 'package:app_test/modules/authentication/data/models/auth_model.dart';
import 'package:app_test/modules/authentication/data/models/result_auth_model.dart';
import 'package:app_test/modules/authentication/data/repositories/auth_repository_impl.dart';
import 'package:app_test/modules/authentication/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AuthDataSourceMock extends Mock implements AuthDatasource {}

void main() {
  final datasource = AuthDataSourceMock();
  final repository = AuthRepositoryImpl(datasource);
  final AuthModel authModel =
      AuthModel(email: 'teste@teste.com', password: 'password');
  final ResultAuthModel resultAuthModel =
      ResultAuthModel(token: 'pqlawhbdasdiuabdaskjbAASASkjbkb12kbn');

  test('should return ResultAuthEntity', () async {
    when(datasource.auth(authModel)).thenAnswer((_) async => resultAuthModel);
    final result = await repository.auth(authModel);
    expect(result, isA<ResultAuthModel>);
  });

  test('should return DataSource error if datasource fail', () async {
    when(datasource.auth(authModel)).thenThrow(Exception());

    final result = await repository.auth(authModel);
    expect(result.fold(id, id), isA<DataSourceError>);
  });
}
