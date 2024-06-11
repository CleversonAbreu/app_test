import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication/data/repositories/auth_repository_impl.dart';
import 'authentication/data/repositories/token_repository_impl.dart';

import 'authentication/domain/repositories/auth_repository.dart';
import 'authentication/domain/repositories/token_repository.dart';
import 'authentication/domain/usecases/result_login_usecase.dart';
import 'authentication/external/datasources/auth_datasource_impl.dart';
import 'authentication/presenter/cubit/auth_cubit.dart';

import 'authentication/presenter/pages/auth_page.dart';
import 'home/presenter/pages/home_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    AsyncBind<SharedPreferences>(
        (i) async => await SharedPreferences.getInstance()),
    Bind((i) => Dio()),
    Bind((i) => AuthDataSourceImpl(i())),
    Bind<AuthRepository>((i) => AuthRepositoryImpl(i())),
    Bind((i) => ResultAuthUsecaseImpl(repository: i<AuthRepository>())),
    Bind.lazySingleton<AuthCubit>(
        (i) => AuthCubit(i.get<ResultAuthUsecase>(), i.get<TokenRepository>())),
    Bind.lazySingleton<TokenRepository>(
      (i) => TokenRepositoryImpl(),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/auth', child: (_, __) => const AuthPage()),
    ChildRoute('/home', child: (_, __) => const HomePage()),
  ];
}
