import 'package:app_test/modules/auth/signup/data/models/signup_model.dart';
import 'package:app_test/modules/auth/signup/domain/entities/signup_entity.dart';
import 'package:app_test/modules/auth/signup/domain/repositories/signup_repository.dart';
import 'package:app_test/modules/auth/signup/errors/signup_error.dart';
import 'package:dartz/dartz.dart';

class SignUpUsecase {
  final SignUpRepository repository;

  SignUpUsecase(this.repository);

  Future<Either<SignUpError, SignUpEntity>> call(SignUpModel signUpModel) async {
    return await repository.signUp(signUpModel);
  }
}