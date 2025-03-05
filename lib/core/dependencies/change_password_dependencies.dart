import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/auth/change_password/data/datasource/change_password_remote_datasource.dart';
import 'package:app_test/modules/auth/change_password/data/datasource/change_password_remote_datasource_impl.dart';
import 'package:app_test/modules/auth/change_password/data/repositories/change_password_repository_impl.dart';
import 'package:app_test/modules/auth/change_password/domain/repositories/change_password_repository.dart';
import 'package:app_test/modules/auth/change_password/domain/usecases/change_password_usecase.dart';
import 'package:app_test/modules/auth/change_password/presenter/cubit/change_password_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupChangePasswordDependencies() {
  // DataSource
  getIt.registerFactory<ChangePasswordRemoteDataSource>(
      () => ChangePasswordRemoteDataSourceImpl(getIt<DioClient>()));
  
  // Repository
  getIt.registerFactory<ChangePasswordRepository>(
      () => ChangePasswordRepositoryImpl(getIt<ChangePasswordRemoteDataSource>()));

  // UseCase
  getIt.registerFactory<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(getIt<ChangePasswordRepository>()));

  // Cubit
  getIt.registerFactory<ChangePasswordCubit>(
      () => ChangePasswordCubit(getIt<ChangePasswordUseCase>()));
}