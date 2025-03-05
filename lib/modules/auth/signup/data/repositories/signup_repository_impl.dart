import 'package:app_test/modules/auth/signup/data/datasources/signup_remote_datasource.dart';
import 'package:app_test/modules/auth/signup/data/models/signup_model.dart';
import 'package:app_test/modules/auth/signup/domain/entities/signup_entity.dart';
import 'package:app_test/modules/auth/signup/domain/repositories/signup_repository.dart';
import 'package:app_test/modules/auth/signup/errors/signup_error.dart';

import 'package:dartz/dartz.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDataSource dataSource;

  SignUpRepositoryImpl(this.dataSource);

  @override
  Future<Either<SignUpError, SignUpEntity>> signUp(SignUpModel signUpModel) async {
    return await dataSource.signUp(signUpModel);
  }
}