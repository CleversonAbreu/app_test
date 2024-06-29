import 'package:email_otp/email_otp.dart';

abstract class OTPRemoteDataSource {
  Future<void> sendOTP(String email);
  Future<bool> verifyOTP(String code);
}

class OTPRemoteDataSourceImpl implements OTPRemoteDataSource {
  final EmailOTP emailOTP = EmailOTP();

  @override
  Future<void> sendOTP(String email) async {
    emailOTP.setConfig(
      appEmail: email,
      appName: 'Base App',
      userEmail: email,
      otpLength: 6,
      otpType: OTPType.digitsOnly,
    );
    await emailOTP.sendOTP();
  }

  @override
  Future<bool> verifyOTP(String code) async {
    return await emailOTP.verifyOTP(otp: code);
  }
}
