import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:app_test/modules/user/profile/data/datasources/profile_remote_datasource.dart';
import 'package:app_test/modules/user/profile/data/models/profile_model.dart';
import 'package:app_test/modules/user/profile/data/repositories/profile_repository_impl.dart';
import 'package:app_test/modules/user/profile/domain/entities/profile_entity.dart';

import 'profile_reposity_impl_tet.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource])
void main() {
  late ProfileRepositoryImpl repository;
  late MockProfileRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockProfileRemoteDataSource();
    repository = ProfileRepositoryImpl(mockRemoteDataSource);
  });

  group('ProfileRepositoryImpl', () {
    test('should return a ProfileEntity when getProfile is called', () async {
      final profileModel = ProfileModel(id: 1, name: 'John Doe', email: 'john.doe@example.com', avatarUrl: '');
      when(mockRemoteDataSource.getProfile()).thenAnswer((_) async => profileModel);

      final result = await repository.getProfile();

      expect(result, isA<ProfileEntity>());
      expect(result.name, 'John Doe');
      expect(result.email, 'john.doe@example.com');
    });

    test('should call updateProfile with the correct profile model', () async {
      final profileEntity = ProfileEntity(id: 1, name: 'John Doe', email: 'john.doe@example.com', avatarUrl: '');
      final profileModel = ProfileModel(id: 1, name: 'John Doe', email: 'john.doe@example.com', avatarUrl: '');

      when(mockRemoteDataSource.updateProfile(profileModel)).thenAnswer((_) async => {});

      await repository.updateProfile(profileEntity);

      verify(mockRemoteDataSource.updateProfile(profileModel)).called(1);
    });
  });
}
