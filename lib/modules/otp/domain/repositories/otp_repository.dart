abstract class OTPRepository {
  Future<void> sendOTP(String email);
  Future<bool> verifyOTP(String code);
}
