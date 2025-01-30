import 'package:app_test/core/constants/app_routes.dart';
import 'package:app_test/core/theme/app_collors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_test/modules/common/presenter/widgets/buttons/icon_button_loading.dart';
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
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // ScreenUtil.init(
    //   context,
    //   designSize: Size(width, height),
    //   minTextAdapt: true,
    //   splitScreenMode: true,
    // );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightSecondary,
        title: const Text(
          'Profile',
          style: TextStyle(color: AppColors.lightBackground),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).go(AppRoutes.settings),
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
                      style: const TextStyle(color: AppColors.lightSecondary),
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

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    color: AppColors.lightSecondary,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(profile.avatarUrl),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Change Picture',
                              style: TextStyle(
                                color: AppColors.lightBackground,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: profile.name,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            context.read<ProfileCubit>().updateProfile(
                                  profile.copyWith(name: value),
                                );
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: profile.email,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            context.read<ProfileCubit>().updateProfile(
                                  profile.copyWith(email: value),
                                );
                          },
                        ),
                        Expanded(child: Container()), // Spacer
                        SizedBox(
                          height: 56.h,
                          child: IconButtonLoading(
                            title: 'Update',
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.lightBackground,
                              size: 18,
                            ),
                            onPressed: () => {},
                            isLoading: false,
                          ),
                        ),
                      ],
                    ),
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
