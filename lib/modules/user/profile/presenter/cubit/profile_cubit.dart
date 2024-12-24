import 'package:app_test/modules/user/profile/domain/entities/profile_entity.dart';
import 'package:app_test/modules/user/profile/domain/usecases/get_profile_usecase.dart';
import 'package:app_test/modules/user/profile/domain/usecases/update_profile_usecase.dart';
import 'package:app_test/modules/user/profile/presenter/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
  }) : super(ProfileState(isLoading: true));

  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final profile = await getProfileUseCase();
      emit(state.copyWith(profile: profile, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> updateProfile(ProfileEntity updatedProfile) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await updateProfileUseCase(updatedProfile);
      emit(state.copyWith(profile: updatedProfile, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
