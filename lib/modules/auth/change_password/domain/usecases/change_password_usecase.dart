
import 'package:app_test/modules/auth/change_password/domain/entities/change_password_entity.dart';
import 'package:app_test/modules/auth/change_password/domain/repositories/change_password_repository.dart';

class ChangePasswordUseCase {
  final ChangePasswordRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<void> call(ChangePasswordEntity params) async {
    return repository.changePassword(params);
  }

}
