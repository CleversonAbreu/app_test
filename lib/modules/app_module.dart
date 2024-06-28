import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_otp/email_otp.dart';
import 'auth/authentication/data/repositories/auth_repository_impl.dart';
import 'auth/authentication/data/repositories/token_repository_impl.dart';
import 'auth/authentication/domain/repositories/auth_repository.dart';
import 'auth/authentication/domain/repositories/token_repository.dart';
import 'auth/authentication/domain/usecases/result_auth_usecase.dart';
import 'auth/authentication/external/datasources/auth_datasource_impl.dart';
import 'auth/authentication/presenter/cubit/auth_cubit.dart';
import 'auth/authentication/presenter/pages/auth_page.dart';
import 'auth/biometry/presenter/pages/biometry_page.dart';
import 'auth/otp/data/datasources/otp_remote_datasource.dart';
import 'auth/otp/data/repositories/otp_repository_impl.dart';
import 'auth/otp/domain/repositories/otp_repository.dart';
import 'auth/otp/domain/usecases/send_otp_usecase.dart';
import 'auth/otp/domain/usecases/verify_otp_usecase.dart';
import 'auth/otp/presenter/cubit/otp_cubit.dart';
import 'home/presenter/pages/home_page.dart';

import 'auth/onboarding/presenter/pages/onboarding_one_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    AsyncBind<SharedPreferences>(
      (i) async => await SharedPreferences.getInstance(),
    ),
    Bind((i) => Dio()),
    Bind((i) => AuthDataSourceImpl(i())),
    Bind<AuthRepository>((i) => AuthRepositoryImpl(i())),
    Bind((i) => ResultAuthUsecaseImpl(repository: i<AuthRepository>())),
    Bind.lazySingleton<AuthCubit>(
      (i) => AuthCubit(i.get<ResultAuthUsecase>(), i.get<TokenRepository>()),
    ),
    Bind.lazySingleton<TokenRepository>(
      (i) => TokenRepositoryImpl(),
    ),
    Bind((i) => EmailOTP()),
    Bind<OTPRemoteDataSource>((i) => OTPRemoteDataSourceImpl()),
    Bind<OTPRepository>((i) => OTPRepositoryImpl(i.get<OTPRemoteDataSource>())),
    Bind((i) => SendOTP(i.get<OTPRepository>())),
    Bind((i) => VerifyOTP(i.get<OTPRepository>())),
    Bind.lazySingleton<OTPCubit>(
      (i) => OTPCubit(
        sendOTP: i.get<SendOTP>(),
        verifyOTP: i.get<VerifyOTP>(),
      ),
    ),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/auth', child: (_, __) => const AuthPage()),
        ChildRoute('/home', child: (_, __) => const HomePage()),
        ChildRoute('/biometry', child: (_, __) => BiometryPage()),
        ChildRoute('/onboarding', child: (_, __) => OnboardingOnePage())
      ];
}
