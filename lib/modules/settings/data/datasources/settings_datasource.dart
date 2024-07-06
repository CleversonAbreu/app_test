abstract class SettingsLocalDataSource {
  Future<void> saveTheme(bool isDarkMode);
  Future<bool?> getTheme();
  Future<void> saveLocale(String locale);
  Future<String?> getLocale();
  Future<void> saveBiometricPreference(bool isEnabled);
  Future<bool?> getBiometricPreference();
}
