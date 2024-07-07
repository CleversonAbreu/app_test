import 'package:app_test/modules/settings/domain/repositories/settings_repository.dart';
import 'package:app_test/modules/settings/domain/usecases/settings_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:app_test/modules/settings/domain/usecases/settings_usecase.dart';

import 'settings_usecase_impl_test.mocks.dart';

// Gerar mocks para o SettingsRepository
@GenerateMocks([SettingsRepository])
void main() {
  late SettingsUseCaseImpl useCase;
  late MockSettingsRepository mockSettingsRepository;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    useCase = SettingsUseCaseImpl(settingsRepository: mockSettingsRepository);
  });

  group('SettingsUseCaseImpl', () {
    test('should save theme preference', () async {
      // Arrange
      const isDarkMode = true;

      // Act
      await useCase.updateTheme(isDarkMode);

      // Assert
      verify(mockSettingsRepository.saveTheme(isDarkMode)).called(1);
    });

    test('should fetch theme preference', () async {
      // Arrange
      const isDarkMode = true;
      when(mockSettingsRepository.getTheme())
          .thenAnswer((_) async => isDarkMode);

      // Act
      final result = await useCase.fetchTheme();

      // Assert
      expect(result, isDarkMode);
      verify(mockSettingsRepository.getTheme()).called(1);
    });

    test('should get biometric preference', () async {
      // Arrange
      const isEnabled = true;
      when(mockSettingsRepository.getBiometricPreference())
          .thenAnswer((_) async => isEnabled);

      // Act
      final result = await useCase.getBiometricPreference();

      // Assert
      expect(result, isEnabled);
      verify(mockSettingsRepository.getBiometricPreference()).called(1);
    });

    test('should save biometric preference', () async {
      // Arrange
      const isEnabled = true;

      // Act
      await useCase.saveBiometricPreference(isEnabled);

      // Assert
      verify(mockSettingsRepository.saveBiometricPreference(isEnabled))
          .called(1);
    });

    test('should update locale', () async {
      // Arrange
      const locale = 'en_US';

      // Act
      await useCase.updateLocale(locale);

      // Assert
      verify(mockSettingsRepository.saveLocale(locale)).called(1);
    });

    test('should fetch locale', () async {
      // Arrange
      const locale = 'en_US';
      when(mockSettingsRepository.getLocale()).thenAnswer((_) async => locale);

      // Act
      final result = await useCase.fetchLocale();

      // Assert
      expect(result, locale);
      verify(mockSettingsRepository.getLocale()).called(1);
    });
  });
}
