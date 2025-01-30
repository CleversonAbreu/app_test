
import 'package:app_test/modules/auth/change_password/data/datasource/change_password_remote_datasource.dart';
import 'package:app_test/modules/auth/change_password/domain/entities/change_password_entity.dart';
import 'package:app_test/modules/auth/change_password/domain/repositories/change_password_repository.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordRemoteDataSource remoteDataSource;

  ChangePasswordRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> changePassword(ChangePasswordEntity params) async {
    return await remoteDataSource.changePassword(params);
  }
}
