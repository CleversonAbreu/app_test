import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:app_test/modules/user/profile/domain/entities/profile_entity.dart';
import 'package:app_test/modules/user/profile/domain/repositories/profile_repository.dart';
import 'package:app_test/modules/user/profile/domain/usecases/get_profile_usecase.dart';

import 'get_profile_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late GetProfileUseCase useCase;
  late MockProfileRepository mockRepository;

  setUp(() {
    mockRepository = MockProfileRepository();
    useCase = GetProfileUseCase(mockRepository);
  });

  group('GetProfileUseCase', () {
    test('should return a ProfileEntity when call is successful', () async {
      final profileEntity = ProfileEntity(id: 1, name: 'John Doe', email: 'john.doe@example.com', avatarUrl: '');
      when(mockRepository.getProfile()).thenAnswer((_) async => profileEntity);

      final result = await useCase.call();

      expect(result, isA<ProfileEntity>());
      expect(result.name, 'John Doe');
      expect(result.email, 'john.doe@example.com');
    });
  });
}
