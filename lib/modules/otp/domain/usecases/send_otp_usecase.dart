import '../repositories/otp_repository.dart';

class SendOTP {
  final OTPRepository repository;

  SendOTP(this.repository);

  Future<void> call(String email) {
    return repository.sendOTP(email);
  }
}
