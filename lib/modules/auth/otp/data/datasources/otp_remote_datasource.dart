import 'package:email_otp/email_otp.dart';

abstract class OTPRemoteDataSource {
  Future<void> sendOTP(String email);
  Future<bool> verifyOTP(String code);
}
