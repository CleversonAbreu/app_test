import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:app_test/modules/settings/domain/repositories/settings_repository.dart';
import 'package:app_test/modules/settings/data/repositories/settings_repository_impl.dart';
import 'package:app_test/modules/settings/data/datasources/settings_datasource.dart';

import 'settings_repository_impl_test.mocks.dart';

// Gerar mocks para o SettingsLocalDataSource
@GenerateMocks([SettingsLocalDataSource])
void main() {
  late SettingsRepositoryImpl repository;
  late MockSettingsLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockSettingsLocalDataSource();
    repository = SettingsRepositoryImpl(mockLocalDataSource);
  });

  group('SettingsRepositoryImpl', () {
    test('should save theme preference', () async {
      // Arrange
      const isDarkMode = true;

      // Act
      await repository.saveTheme(isDarkMode);

      // Assert
      verify(mockLocalDataSource.saveTheme(isDarkMode)).called(1);
    });

    test('should fetch theme preference', () async {
      // Arrange
      const isDarkMode = true;
      when(mockLocalDataSource.getTheme()).thenAnswer((_) async => isDarkMode);

      // Act
      final result = await repository.getTheme();

      // Assert
      expect(result, isDarkMode);
      verify(mockLocalDataSource.getTheme()).called(1);
    });

    test('should save locale', () async {
      // Arrange
      const locale = 'en_US';

      // Act
      await repository.saveLocale(locale);

      // Assert
      verify(mockLocalDataSource.saveLocale(locale)).called(1);
    });

    test('should fetch locale', () async {
      // Arrange
      const locale = 'en_US';
      when(mockLocalDataSource.getLocale()).thenAnswer((_) async => locale);

      // Act
      final result = await repository.getLocale();

      // Assert
      expect(result, locale);
      verify(mockLocalDataSource.getLocale()).called(1);
    });

    test('should save biometric preference', () async {
      // Arrange
      const isEnabled = true;

      // Act
      await repository.saveBiometricPreference(isEnabled);

      // Assert
      verify(mockLocalDataSource.saveBiometricPreference(isEnabled)).called(1);
    });

    test('should fetch biometric preference', () async {
      // Arrange
      const isEnabled = true;
      when(mockLocalDataSource.getBiometricPreference())
          .thenAnswer((_) async => isEnabled);

      // Act
      final result = await repository.getBiometricPreference();

      // Assert
      expect(result, isEnabled);
      verify(mockLocalDataSource.getBiometricPreference()).called(1);
    });
  });
}
