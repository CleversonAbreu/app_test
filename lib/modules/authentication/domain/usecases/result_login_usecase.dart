import 'package:dartz/dartz.dart';

import '../../data/models/auth_model.dart';
import '../entities/result_auth_entity.dart';
import '../errors/errors.dart';
import '../repositories/auth_repository.dart';

abstract class ResultAuthUsecase {
  Future<Either<AuthFailure, ResultAuthEntity>> call(AuthModel authModel);
}

class ResultAuthUsecaseImpl implements ResultAuthUsecase {
  final AuthRepository repository;

  ResultAuthUsecaseImpl({required this.repository});

  @override
  Future<Either<AuthFailure, ResultAuthEntity>> call(
      AuthModel authModel) async {
    if (authModel.email.isEmpty || authModel.password.isEmpty) {
      return Left(InvalidCredentials());
    }
    return await repository.auth(authModel);
  }
}
