import 'package:app_test/modules/service_locator.dart';
import 'package:app_test/modules/user/profile/domain/usecases/get_profile_usecase.dart';
import 'package:app_test/modules/user/profile/domain/usecases/update_profile_usecase.dart';
import 'package:app_test/modules/user/profile/presenter/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).go('/settings'),
        ),
      ),
      body: BlocProvider(
        create: (context) => ProfileCubit(
          getProfileUseCase: getIt<GetProfileUseCase>(),
          updateProfileUseCase: getIt<UpdateProfileUseCase>(),
        )..loadProfile(),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.error!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<ProfileCubit>().loadProfile(),
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              );
            }

            final profile = state.profile;
            if (profile == null) {
              return const Center(child: Text('Perfil não encontrado'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container para exibir a foto de perfil
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(profile.avatarUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: profile.name,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    onChanged: (value) {
                      context.read<ProfileCubit>().updateProfile(
                            profile.copyWith(name: value),
                          );
                    },
                  ),
                  TextFormField(
                    initialValue: profile.email,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    onChanged: (value) {
                      context.read<ProfileCubit>().updateProfile(
                            profile.copyWith(email: value),
                          );
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final updatedProfile = profile.copyWith(
                        name: profile.name,
                        email: profile.email,
                      );
                      context.read<ProfileCubit>().updateProfile(updatedProfile);
                    },
                    child: const Text('Salvar Alterações'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
