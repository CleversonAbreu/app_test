// import 'package:shared_preferences/shared_preferences.dart';

// class SettingsRepository {
//   static const _themeKey = 'theme';
//   static const _localeKey = 'locale';

//   Future<void> saveTheme(bool isDarkMode) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_themeKey, isDarkMode);
//   }

//   Future<bool?> getTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_themeKey);
//   }

//   Future<void> saveLocale(String locale) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_localeKey, locale);
//   }

//   Future<String?> getLocale() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_localeKey);
//   }
// }

import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static const _themeKey = 'theme';
  static const _localeKey = 'locale';
  static const _biometricKey = 'biometric';

  Future<void> saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkMode);
  }

  Future<bool?> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey);
  }

  Future<void> saveLocale(String locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale);
  }

  Future<String?> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeKey);
  }

  Future<void> saveBiometricPreference(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricKey, isEnabled);
  }

  Future<bool?> getBiometricPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricKey);
  }
}
