import 'package:app_test/modules/user/profile/domain/entities/profile_entity.dart';

class ProfileState {
  final ProfileEntity? profile;
  final String? error;
  final bool isLoading;

  ProfileState({this.profile, this.error, this.isLoading = false});

  ProfileState copyWith({
    ProfileEntity? profile,
    String? error,
    bool? isLoading,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
