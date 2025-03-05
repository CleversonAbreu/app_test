abstract class OTPRepository {
  Future<void> sendOTP(String email, String typeGenerate);
  Future<bool> verifyOTP(String email,String code);
}
