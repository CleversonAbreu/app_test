import 'package:app_test/modules/authentication/domain/errors/errors.dart';

import 'package:dartz/dartz.dart';

import '../../domain/entities/result_auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';
import '../models/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);
  @override
  Future<Either<AuthFailure, ResultAuthEntity>> auth(
      AuthModel authModel) async {
    try {
      final result = await datasource.auth(authModel);
      return Right(result);
    } on DataSourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DataSourceError(message: e.toString()));
    }
  }
}
