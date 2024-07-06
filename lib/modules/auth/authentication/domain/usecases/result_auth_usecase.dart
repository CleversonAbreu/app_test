import 'package:dartz/dartz.dart';

import '../../data/models/auth_model.dart';
import '../entities/result_auth_entity.dart';
import '../errors/errors.dart';

abstract class ResultAuthUsecase {
  Future<Either<AuthFailure, ResultAuthEntity>> call(AuthModel authModel);
}
