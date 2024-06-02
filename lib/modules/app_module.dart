import 'package:app_test/modules/login/external/datasources/login_datasource_impl.dart';
import 'package:app_test/modules/login/presenter/pages/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import 'app_widget.dart';
import 'login/data/repositories/login_repository_impl.dart';
import 'login/domain/repositories/login_repository.dart';
import 'login/domain/usecases/result_login_usecase.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => Dio()),
    Bind((i) => LoginDataSourceImpl(i())),
    Bind<LoginRepository>((i) => LoginRepositoryImpl(i())),
    Bind((i) => ResultLoginUsecaseImpl(repository: i<LoginRepository>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, __) => const LoginPage()),
  ];
}
