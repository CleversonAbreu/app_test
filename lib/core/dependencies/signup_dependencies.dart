import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/auth/signup/data/datasources/signup_remote_datasource.dart';
import 'package:app_test/modules/auth/signup/data/datasources/signup_remote_datasource_impl.dart';
import 'package:app_test/modules/auth/signup/data/repositories/signup_repository_impl.dart';
import 'package:app_test/modules/auth/signup/domain/repositories/signup_repository.dart';
import 'package:app_test/modules/auth/signup/domain/usecases/signup_usecase.dart';
import 'package:app_test/modules/auth/signup/presenter/cubit/signup_cubit.dart';

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupSignUpDependencies() {
  // DataSource
  // SignUpRemoteDataSource
  getIt.registerFactory<SignUpUsecase>(() => SignUpUsecase(getIt<SignUpRepository>()));

  // SignUpCubit
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt<SignUpUsecase>()));
   getIt.registerLazySingleton<SignUpRepository>(
    () => SignUpRepositoryImpl(getIt<SignUpRemoteDataSource>()),
  );

  // SignUpRemoteDataSource
  getIt.registerLazySingleton<SignUpRemoteDataSource>(
    () => SignUpRemoteDataSourceImpl(getIt<DioClient>()),
  );  
}