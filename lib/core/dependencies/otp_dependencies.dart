import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/auth/otp/data/datasources/otp_remote_datasource.dart';
import 'package:app_test/modules/auth/otp/data/datasources/otp_remote_datasource_impl.dart';
import 'package:app_test/modules/auth/otp/data/repositories/otp_repository_impl.dart';
import 'package:app_test/modules/auth/otp/domain/repositories/otp_repository.dart';
import 'package:app_test/modules/auth/otp/domain/usecases/send_otp_usecase.dart';
import 'package:app_test/modules/auth/otp/domain/usecases/verify_otp_usecase.dart';

import 'package:app_test/modules/auth/otp/presenter/cubit/otp_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupOtpDependencies() {
  // DataSource
  getIt.registerFactory<OTPRemoteDataSource>(() => OTPRemoteDataSourceImpl(getIt<DioClient>()));

  // Repository
  getIt.registerFactory<OTPRepository>(() => OTPRepositoryImpl(getIt<OTPRemoteDataSource>()));

  //  SendOTP using OTPRepository
  getIt.registerFactory<SendOTP>(() => SendOTP(getIt<OTPRepository>()));

  //  VerifyOTP using OTPRepository
  getIt.registerFactory<VerifyOTP>(() => VerifyOTP(getIt<OTPRepository>()));

  //  OTPCubit
  getIt.registerFactory<OTPCubit>(() => OTPCubit(
        sendOTP: getIt<SendOTP>(),
        verifyOTP: getIt<VerifyOTP>(),
      ));
} 

