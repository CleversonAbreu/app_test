import '../data/repositories/settings_repository.dart';

class GetBiometricPreference {
  final SettingsRepository repository;

  GetBiometricPreference(this.repository);

  Future<bool?> call() async {
    return await repository.getBiometricPreference();
  }
}
