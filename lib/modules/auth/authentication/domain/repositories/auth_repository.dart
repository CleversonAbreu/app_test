import 'package:app_test/modules/auth/authentication/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/auth_model.dart';
import '../entities/result_auth_entity.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, ResultAuthEntity>> auth(AuthModel authModel);
}
