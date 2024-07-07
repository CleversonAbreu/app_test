import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_test/modules/settings/data/datasources/settings_datasource.dart';
import 'package:app_test/modules/settings/data/datasources/settings_datasource_impl.dart';

import 'settings_local_datasource_impl_test.mocks.dart';

// Gerar mocks para o SharedPreferences
@GenerateMocks([SharedPreferences])
void main() {
  late SettingsLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = SettingsLocalDataSourceImpl(mockSharedPreferences);
  });

  group('SettingsLocalDataSourceImpl', () {
    const String _themeKey = 'theme';
    const String _localeKey = 'locale';
    const String _biometricKey = 'biometric';
    test('should save theme preference', () async {
      // Arrange
      const isDarkMode = true;
      when(mockSharedPreferences.setBool(any, any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.saveTheme(isDarkMode);

      // Assert
      verify(mockSharedPreferences.setBool(_themeKey, isDarkMode)).called(1);
    });

    test('should fetch theme preference', () async {
      // Arrange
      const isDarkMode = true;
      when(mockSharedPreferences.getBool(any)).thenReturn(isDarkMode);

      // Act
      final result = await dataSource.getTheme();

      // Assert
      expect(result, isDarkMode);
      verify(mockSharedPreferences.getBool(_themeKey)).called(1);
    });

    test('should save locale', () async {
      // Arrange
      const locale = 'en_US';
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.saveLocale(locale);

      // Assert
      verify(mockSharedPreferences.setString(_localeKey, locale)).called(1);
    });

    test('should fetch locale', () async {
      // Arrange
      const locale = 'en_US';
      when(mockSharedPreferences.getString(any)).thenReturn(locale);

      // Act
      final result = await dataSource.getLocale();

      // Assert
      expect(result, locale);
      verify(mockSharedPreferences.getString(_localeKey)).called(1);
    });

    test('should save biometric preference', () async {
      // Arrange
      const isEnabled = true;
      when(mockSharedPreferences.setBool(any, any))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.saveBiometricPreference(isEnabled);

      // Assert
      verify(mockSharedPreferences.setBool(_biometricKey, isEnabled)).called(1);
    });

    test('should fetch biometric preference', () async {
      // Arrange
      const isEnabled = true;
      when(mockSharedPreferences.getBool(any)).thenReturn(isEnabled);

      // Act
      final result = await dataSource.getBiometricPreference();

      // Assert
      expect(result, isEnabled);
      verify(mockSharedPreferences.getBool(_biometricKey)).called(1);
    });
  });
}
