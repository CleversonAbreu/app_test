import 'package:app_test/modules/authentication/data/datasources/login_datasource.dart';
import 'package:app_test/modules/authentication/data/models/login_model.dart';
import 'package:app_test/modules/authentication/data/models/result_login_model.dart';
import 'package:app_test/modules/authentication/data/repositories/login_repository_impl.dart';
import 'package:app_test/modules/authentication/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginDataSourceMock extends Mock implements LoginDatasource {}

void main() {
  final datasource = LoginDataSourceMock();
  final repository = LoginRepositoryImpl(datasource);
  final LoginModel loginModel =
      LoginModel(email: 'teste@teste.com', password: 'password');
  final ResultLoginModel resultLoginModel =
      ResultLoginModel(token: 'pqlawhbdasdiuabdaskjbAASASkjbkb12kbn');

  test('should return ResultLoginEntity', () async {
    when(datasource.login(loginModel))
        .thenAnswer((_) async => resultLoginModel);
    final result = await repository.login(loginModel);
    expect(result, isA<ResultLoginModel>);
  });

  test('should return DataSource error if datasource fail', () async {
    when(datasource.login(loginModel)).thenThrow(Exception());

    final result = await repository.login(loginModel);
    expect(result.fold(id, id), isA<DataSourceError>);
  });
}
