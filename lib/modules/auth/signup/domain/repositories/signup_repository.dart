import 'package:app_test/modules/auth/signup/data/models/signup_model.dart';
import 'package:app_test/modules/auth/signup/domain/entities/signup_entity.dart';
import 'package:app_test/modules/auth/signup/errors/signup_error.dart';
import 'package:dartz/dartz.dart';

abstract class SignUpRepository {
  Future<Either<SignUpError, SignUpEntity>> signUp(SignUpModel signUpModel);
}