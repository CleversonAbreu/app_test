import 'package:app_test/modules/authentication/data/datasources/login_datasource.dart';
import 'package:app_test/modules/authentication/data/models/login_model.dart';
import 'package:app_test/modules/authentication/domain/entities/result_login_entity.dart';
import 'package:app_test/modules/authentication/domain/errors/errors.dart';
import 'package:app_test/modules/authentication/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource datasource;

  LoginRepositoryImpl(this.datasource);
  @override
  Future<Either<LoginFailure, ResultLoginEntity>> login(
      LoginModel loginModel) async {
    try {
      final result = await datasource.login(loginModel);
      return Right(result);
    } on DataSourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DataSourceError(message: e.toString()));
    }
  }
}
