import 'package:shared_preferences/shared_preferences.dart';

import 'settings_datasource.dart';

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const String _themeKey = 'theme';
  static const String _localeKey = 'locale';
  static const String _biometricKey = 'biometric';

  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveTheme(bool isDarkMode) async {
    await sharedPreferences.setBool(_themeKey, isDarkMode);
  }

  @override
  Future<bool?> getTheme() async {
    return sharedPreferences.getBool(_themeKey);
  }

  @override
  Future<void> saveLocale(String locale) async {
    await sharedPreferences.setString(_localeKey, locale);
  }

  @override
  Future<String?> getLocale() async {
    return sharedPreferences.getString(_localeKey);
  }

  @override
  Future<void> saveBiometricPreference(bool isEnabled) async {
    await sharedPreferences.setBool(_biometricKey, isEnabled);
  }

  @override
  Future<bool?> getBiometricPreference() async {
    return sharedPreferences.getBool(_biometricKey);
  }
}
