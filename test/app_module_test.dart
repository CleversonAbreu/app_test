import 'dart:convert';

import 'package:app_test/modules/authentication/data/models/auth_model.dart';
import 'package:app_test/modules/authentication/domain/usecases/result_login_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'modules/utils/login_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();

  test('should return usecase without error', () {
    final usecase = Modular.get<ResultAuthUsecase>();
    expect(usecase, isA<ResultAuthUsecaseImpl>());
  });

  test('should return ResultAuthEntity', () async {
    final requestOptions = RequestOptions(path: '');
    when(dio.get('')).thenAnswer((_) async => Response(
        data: jsonDecode(authResponse),
        statusCode: 200,
        requestOptions: requestOptions));
    final usecase = Modular.get<ResultAuthUsecase>();
    final result = await usecase(
        AuthModel(email: 'teste@teste.com', password: 'password'));
    expect(result, isA<ResultAuthUsecaseImpl>());
  });
}
