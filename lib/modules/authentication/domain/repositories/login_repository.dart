import 'package:app_test/modules/authentication/data/models/login_model.dart';
import 'package:app_test/modules/authentication/domain/entities/result_login_entity.dart';
import 'package:app_test/modules/authentication/domain/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<LoginFailure, ResultLoginEntity>> login(LoginModel loginModel);
}
