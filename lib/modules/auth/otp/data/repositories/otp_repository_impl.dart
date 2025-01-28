import '../../domain/repositories/otp_repository.dart';
import '../datasources/otp_remote_datasource.dart';

class OTPRepositoryImpl implements OTPRepository {
  final OTPRemoteDataSource remoteDataSource;

  OTPRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> sendOTP(String email) {
    return remoteDataSource.sendOTP(email);
  }

  @override
  Future<bool> verifyOTP(String email, String code) {
    return remoteDataSource.verifyOTP(email, code);
  }
}
