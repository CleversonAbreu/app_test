import 'package:app_test/modules/auth/change_password/domain/entities/change_password_entity.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<void> changePassword(ChangePasswordEntity params);
}