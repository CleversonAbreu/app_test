import 'package:app_test/modules/user/profile/data/models/profile_model.dart';

import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProfileEntity> getProfile() async {
    return remoteDataSource.getProfile();
  }

  @override
  Future<void> updateProfile(ProfileEntity profile) async {
    final profileModel = ProfileModel(
      id: profile.id,
      name: profile.name,
      email: profile.email,
      avatarUrl: '',
    );
    await remoteDataSource.updateProfile(profileModel);
  }
}
