import '../repositories/otp_repository.dart';

class VerifyOTP {
  final OTPRepository repository;

  VerifyOTP(this.repository);

  Future<bool> call(String email, String code) {
    return repository.verifyOTP(email, code);
  }
}
