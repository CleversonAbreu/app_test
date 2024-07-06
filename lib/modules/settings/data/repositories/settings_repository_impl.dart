import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveTheme(bool isDarkMode) async {
    return localDataSource.saveTheme(isDarkMode);
  }

  @override
  Future<bool?> getTheme() {
    return localDataSource.getTheme();
  }

  @override
  Future<void> saveLocale(String locale) async {
    return localDataSource.saveLocale(locale);
  }

  @override
  Future<String?> getLocale() {
    return localDataSource.getLocale();
  }

  @override
  Future<void> saveBiometricPreference(bool isEnabled) async {
    return localDataSource.saveBiometricPreference(isEnabled);
  }

  @override
  Future<bool?> getBiometricPreference() {
    return localDataSource.getBiometricPreference();
  }
}
