import 'package:app_test/modules/authentication/data/models/auth_model.dart';
import 'package:app_test/modules/authentication/domain/entities/result_auth_entity.dart';
import 'package:app_test/modules/authentication/domain/errors/errors.dart';
import 'package:app_test/modules/authentication/domain/repositories/auth_repository.dart';
import 'package:app_test/modules/authentication/domain/usecases/result_login_usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class AuthRepositoryMock extends Mock implements AuthRepository {}

void main() {
  final repository = AuthRepositoryMock();
  final usecase = ResultAuthUsecaseImpl(repository: repository);
  final AuthModel authModel =
      AuthModel(email: 'teste@teste.com', password: 'password');
  final AuthModel authModelEmpty = AuthModel(email: '', password: '');

  test('Should return ResultAuthEntity', () async {
    when(repository.auth(authModel)).thenAnswer(
        (_) async => Right(ResultAuthEntity(token: 'zkoapkzpaopaoipsoan')));

    final result = await usecase(authModel);
    expect(result, isA<Right>());
  });

  test('Should return InvalidCredentials error if credentials are empty',
      () async {
    when(repository.auth(authModelEmpty))
        .thenAnswer((_) async => Left(InvalidCredentials()));

    final result = await usecase(authModelEmpty);
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidCredentials>());
  });
}
