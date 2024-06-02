import 'package:app_test/modules/authentication/data/models/login_model.dart';
import 'package:app_test/modules/authentication/domain/entities/result_login_entity.dart';
import 'package:app_test/modules/authentication/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

import '../errors/errors.dart';

abstract class ResultLoginUsecase {
  Future<Either<LoginFailure, ResultLoginEntity>> call(LoginModel loginModel);
}

class ResultLoginUsecaseImpl implements ResultLoginUsecase {
  final LoginRepository repository;

  ResultLoginUsecaseImpl({required this.repository});

  @override
  Future<Either<LoginFailure, ResultLoginEntity>> call(
      LoginModel loginModel) async {
    if (loginModel.email.isEmpty || loginModel.password.isEmpty) {
      return Left(InvalidCredentials());
    }
    return await repository.login(loginModel);
  }
}
