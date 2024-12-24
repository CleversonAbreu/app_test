import 'package:app_test/modules/user/profile/domain/entities/profile_entity.dart';
import 'package:app_test/modules/user/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<void> call(ProfileEntity profile) async {
    await repository.updateProfile(profile);
  }
}
