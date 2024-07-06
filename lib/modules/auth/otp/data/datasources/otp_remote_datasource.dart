abstract class OTPRemoteDataSource {
  Future<void> sendOTP(String email);
  Future<bool> verifyOTP(String code);
}
