import 'package:app_test/modules/settings/domain/usecases/settings_usecase.dart';

import '../repositories/settings_repository.dart';

class SettingsUseCaseImpl implements SettingsUseCase {
  final SettingsRepository settingsRepository;

  SettingsUseCaseImpl({required this.settingsRepository});

  Future<void> updateTheme(bool isDarkMode) async {
    await settingsRepository.saveTheme(isDarkMode);
  }

  Future<bool?> fetchTheme() async {
    return settingsRepository.getTheme();
  }

  Future<bool?> getBiometricPreference() async {
    return await settingsRepository.getBiometricPreference();
  }

  Future<void> saveBiometricPreference(bool isEnabled) async {
    await settingsRepository.saveBiometricPreference(isEnabled);
  }

  Future<void> updateLocale(String locale) async {
    await settingsRepository.saveLocale(locale);
  }

  Future<String?> fetchLocale() async {
    return settingsRepository.getLocale();
  }
}
