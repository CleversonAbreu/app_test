import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/biometry/data/biometric_repository.dart';
import '../../domain/usecases/settings_usecase.dart';

class BiometricCubit extends Cubit<bool?> {
  final BiometricRepository biometricRepository;
  final SettingsUseCase useCase;

  BiometricCubit({
    required this.useCase,
    required this.biometricRepository,
  }) : super(null) {
    _loadBiometricPreference();
  }

  Future<void> _loadBiometricPreference() async {
    final isEnabled = await useCase.getBiometricPreference();
    emit(isEnabled);
  }

  Future<void> enableBiometricPreference() async {
    await useCase.saveBiometricPreference(true);
    emit(true);
  }

  void toggleBiometricPreference() async {
    final currentPreference = state ?? false;
    final newPreference = !currentPreference;
    await useCase.saveBiometricPreference(newPreference);
    emit(newPreference);
  }
}
