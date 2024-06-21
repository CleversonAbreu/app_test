import 'dart:convert';

import 'package:app_test/modules/auth/authentication/data/models/auth_model.dart';
import 'package:app_test/modules/auth/authentication/domain/errors/errors.dart';
import 'package:app_test/modules/auth/authentication/external/datasources/auth_datasource_impl.dart';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../utils/login_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  final datasource = AuthDataSourceImpl(dio);
  final AuthModel authModel =
      AuthModel(email: 'teste@teste.com', password: 'password');
  test('should return ResultAuthEntity', () async {
    final requestOptions = RequestOptions(path: '');

    when(dio.get('')).thenAnswer(
      (_) async => Response(
        data: jsonDecode(authResponse),
        statusCode: 200,
        requestOptions: requestOptions,
      ),
    );
    final future = datasource.auth(authModel);
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
    final future = datasource.auth(authModel);
    expect(future, throwsA(isA<DataSourceError>()));
  });

  test('should return Exception if Dio return error', () async {
    when(dio.get('')).thenThrow(Exception());
    final future = datasource.auth(authModel);
    expect(future, throwsA(isA<Exception>()));
  });
}
