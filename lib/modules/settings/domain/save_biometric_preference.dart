import '../data/repositories/settings_repository.dart';

class SaveBiometricPreference {
  final SettingsRepository repository;

  SaveBiometricPreference(this.repository);

  Future<void> call(bool isEnabled) async {
    await repository.saveBiometricPreference(isEnabled);
  }
}
