import 'dart:convert';

import 'package:app_test/modules/app_module.dart';
import 'package:app_test/modules/authentication/data/models/login_model.dart';
import 'package:app_test/modules/authentication/domain/usecases/result_login_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'modules/utils/login_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();

  // initModule(AppModule(), changeBinds: [
  //   Bind<Dio>((i) => dio);
  // ]);

  test('should return usecase without error', () {
    final usecase = Modular.get<ResultLoginUsecase>();
    expect(usecase, isA<ResultLoginUsecaseImpl>());
  });

  test('should return ResultLoginEntity', () async {
    final requestOptions = RequestOptions(path: '');
    when(dio.get('')).thenAnswer((_) async => Response(
        data: jsonDecode(loginResponse),
        statusCode: 200,
        requestOptions: requestOptions));
    final usecase = Modular.get<ResultLoginUsecase>();
    final result = await usecase(
        LoginModel(email: 'teste@teste.com', password: 'password'));
    expect(result, isA<ResultLoginUsecaseImpl>());
  });
}
