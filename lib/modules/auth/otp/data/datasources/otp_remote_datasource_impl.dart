// import 'package:email_otp/email_otp.dart';

// import 'otp_remote_datasource.dart';

// class OTPRemoteDataSourceImpl implements OTPRemoteDataSource {
//   final EmailOTP emailOTP = EmailOTP();

//   @override
//   Future<void> sendOTP(String email) async {
//     emailOTP.setConfig(
//       appEmail: email,
//       appName: 'Base App',
//       userEmail: email,
//       otpLength: 6,
//       otpType: OTPType.digitsOnly,
//     );
//     await emailOTP.sendOTP();
//   }

//   @override
//   Future<bool> verifyOTP(String code) async {
//     return await emailOTP.verifyOTP(otp: code);
//   }
// }

import 'package:email_otp/email_otp.dart';

import 'otp_remote_datasource.dart';

class OTPRemoteDataSourceImpl implements OTPRemoteDataSource {
  final EmailOTP emailOTP;

  OTPRemoteDataSourceImpl(this.emailOTP);

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
