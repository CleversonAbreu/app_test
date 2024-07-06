abstract class SettingsUseCase {
  Future<void> updateTheme(bool isDarkMode);
  Future<bool?> fetchTheme();

  Future<bool?> getBiometricPreference();
  Future<void> saveBiometricPreference(bool isEnabled);

  Future<void> updateLocale(String locale);
  Future<String?> fetchLocale();
}
