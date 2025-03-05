abstract class OTPRemoteDataSource {
  Future<void> sendOTP(String email, String typeGenerate);
  Future<bool> verifyOTP(String eamil, String code);
}
