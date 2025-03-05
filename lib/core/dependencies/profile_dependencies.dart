import 'package:get_it/get_it.dart';
import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/user/profile/data/datasources/profile_remote_datasource.dart';
import 'package:app_test/modules/user/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:app_test/modules/user/profile/data/repositories/profile_repository_impl.dart';
import 'package:app_test/modules/user/profile/domain/repositories/profile_repository.dart';
import 'package:app_test/modules/user/profile/domain/usecases/get_profile_usecase.dart';
import 'package:app_test/modules/user/profile/domain/usecases/update_profile_usecase.dart';
import 'package:app_test/modules/user/profile/presenter/cubit/profile_cubit.dart';

final getIt = GetIt.instance;

void setupProfileDependencies() {
  // DataSource
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(getIt<DioClient>()));

  // Repository
  getIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(getIt<ProfileRemoteDataSource>()));

  // UseCases
  getIt.registerLazySingleton<GetProfileUseCase>(
      () => GetProfileUseCase(getIt<ProfileRepository>()));
  getIt.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(getIt<ProfileRepository>()));

  // Cubit
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(
        getProfileUseCase: getIt<GetProfileUseCase>(),
        updateProfileUseCase: getIt<UpdateProfileUseCase>()),
  );
}
