import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/biometry/data/biometric_repository.dart';
import '../../domain/get_biometric_preference.dart';
import '../../domain/save_biometric_preference.dart';

class BiometricCubit extends Cubit<bool?> {
  final SaveBiometricPreference saveBiometricPreference;
  final GetBiometricPreference getBiometricPreference;
  final BiometricRepository biometricRepository;

  BiometricCubit({
    required this.saveBiometricPreference,
    required this.getBiometricPreference,
    required this.biometricRepository,
  }) : super(null) {
    _loadBiometricPreference();
  }

  Future<void> _loadBiometricPreference() async {
    final isEnabled = await getBiometricPreference();
    emit(isEnabled);
  }

  Future<void> enableBiometricPreference() async {
    await saveBiometricPreference(true);
    emit(true);
  }

  void toggleBiometricPreference() async {
    final currentPreference = state ?? false;
    final newPreference = !currentPreference;
    await saveBiometricPreference(newPreference);
    emit(newPreference);
  }
}
