import 'package:get_it/get_it.dart';
import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/auth/authentication/data/datasources/auth_datasource.dart';
import 'package:app_test/modules/auth/authentication/data/datasources/auth_datasource_impl.dart';
import 'package:app_test/modules/auth/authentication/data/repositories/auth_repository_impl.dart';
import 'package:app_test/modules/auth/authentication/domain/repositories/auth_repository.dart';
import 'package:app_test/modules/auth/authentication/domain/repositories/token_repository.dart';
import 'package:app_test/modules/auth/authentication/domain/usecases/result_auth_usecase.dart';
import 'package:app_test/modules/auth/authentication/domain/usecases/result_auth_usecase_impl.dart';
import 'package:app_test/modules/auth/authentication/presenter/cubit/auth_cubit.dart';
import 'package:app_test/modules/auth/authentication/data/repositories/token_repository_impl.dart';

final getIt = GetIt.instance;

void setupAuthDependencies() {
  // DataSource
  getIt.registerFactory<AuthDatasource>(
      () => AuthDataSourceImpl(getIt<DioClient>()));

  // Repository
  getIt.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthDatasource>()));

  // Token Repository
  getIt.registerFactory<TokenRepository>(() => TokenRepositoryImpl());

  // UseCase
  getIt.registerFactory<ResultAuthUsecase>(
      () => ResultAuthUsecaseImpl(repository: getIt<AuthRepository>()));

  // Cubit
  getIt.registerFactory<AuthCubit>(
      () => AuthCubit(getIt<ResultAuthUsecase>(), getIt<TokenRepository>()));
}