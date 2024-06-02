import 'package:app_test/modules/authentication/data/models/login_model.dart';
import 'package:app_test/modules/authentication/domain/entities/result_login_entity.dart';
import 'package:app_test/modules/authentication/domain/errors/errors.dart';
import 'package:app_test/modules/authentication/domain/repositories/login_repository.dart';
import 'package:app_test/modules/authentication/domain/usecases/result_login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {}

void main() {
  final repository = LoginRepositoryMock();
  final usecase = ResultLoginUsecaseImpl(repository: repository);
  final LoginModel loginModel =
      LoginModel(email: 'teste@teste.com', password: 'password');
  final LoginModel loginModelEmpty = LoginModel(email: '', password: '');

  test('Should return ResultLoginEntity', () async {
    when(repository.login(loginModel)).thenAnswer(
        (_) async => Right(ResultLoginEntity(token: 'zkoapkzpaopaoipsoan')));

    final result = await usecase(loginModel);
    expect(result, isA<Right>());
  });

  test('Should return InvalidCredentials error if credentials are empty',
      () async {
    when(repository.login(loginModelEmpty))
        .thenAnswer((_) async => Left(InvalidCredentials()));

    final result = await usecase(loginModelEmpty);
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidCredentials>());
  });
}
