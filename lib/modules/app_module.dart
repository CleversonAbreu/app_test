import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication/data/repositories/token_repository_impl.dart';
import 'authentication/data/repositories/login_repository_impl.dart';
import 'authentication/domain/repositories/token_repository.dart';
import 'authentication/domain/repositories/login_repository.dart';
import 'authentication/domain/usecases/result_login_usecase.dart';
import 'authentication/external/datasources/login_datasource_impl.dart';
import 'authentication/presenter/cubit/auth_cubit.dart';
import 'authentication/presenter/pages/login_page.dart';
import 'home/presenter/pages/home_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    AsyncBind<SharedPreferences>(
        (i) async => await SharedPreferences.getInstance()),
    Bind((i) => Dio()),
    Bind((i) => LoginDataSourceImpl(i())),
    Bind<LoginRepository>((i) => LoginRepositoryImpl(i())),
    Bind((i) => ResultLoginUsecaseImpl(repository: i<LoginRepository>())),
    Bind.lazySingleton<AuthCubit>((i) =>
        AuthCubit(i.get<ResultLoginUsecase>(), i.get<TokenRepository>())),
    Bind.lazySingleton<TokenRepository>(
      (i) => TokenRepositoryImpl(),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/login', child: (_, __) => const LoginPage()),
    ChildRoute('/home', child: (_, __) => const HomePage()),
  ];
}
