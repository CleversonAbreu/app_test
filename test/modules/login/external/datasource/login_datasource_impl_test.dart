import 'dart:convert';

import 'package:app_test/modules/login/data/models/login_model.dart';
import 'package:app_test/modules/login/domain/errors/errors.dart';
import 'package:app_test/modules/login/external/datasources/login_datasource_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../utils/login_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  final datasource = LoginDataSourceImpl(dio);
  final LoginModel loginModel =
      LoginModel(email: 'teste@teste.com', password: 'password');
  final LoginModel loginModelEmpty = LoginModel(email: '', password: '');
  test('should return ResultLoginEntity', () async {
    final requestOptions = RequestOptions(path: '');

    when(dio.get('')).thenAnswer(
      (_) async => Response(
        data: jsonDecode(loginResponse),
        statusCode: 200,
        requestOptions: requestOptions,
      ),
    );
    final future = datasource.login(loginModel);
    expect(future, completes);
  });

  test('should return Datasource error if statuscode different from 200',
      () async {
    final requestOptions = RequestOptions(path: '');

    when(dio.get('')).thenAnswer(
      (_) async => Response(
        data: null,
        statusCode: 401,
        requestOptions: requestOptions,
      ),
    );
    final future = datasource.login(loginModel);
    expect(future, throwsA(isA<DataSourceError>()));
  });

  test('should return Exception if Dio return error', () async {
    final requestOptions = RequestOptions(path: '');

    when(dio.get('')).thenThrow(Exception());
    final future = datasource.login(loginModel);
    expect(future, throwsA(isA<Exception>()));
  });
}
