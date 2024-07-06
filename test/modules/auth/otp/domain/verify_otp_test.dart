import 'package:app_test/modules/auth/otp/domain/repositories/otp_repository.dart';
import 'package:app_test/modules/auth/otp/domain/usecases/verify_otp_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'send_otp_test.mocks.dart';

@GenerateMocks([OTPRepository])
void main() {
  late VerifyOTP verifyOTP;
  late MockOTPRepository mockOTPRepository;

  setUp(() {
    mockOTPRepository = MockOTPRepository();
    verifyOTP = VerifyOTP(mockOTPRepository);
  });

  group('VerifyOTP', () {
    final String testCode = '123456';

    test('should call verifyOTP on the repository and return true', () async {
      // Arrange
      when(mockOTPRepository.verifyOTP(testCode)).thenAnswer((_) async => true);

      // Act
      final result = await verifyOTP.call(testCode);

      // Assert
      expect(result, true);
      verify(mockOTPRepository.verifyOTP(testCode)).called(1);
    });

    test('should call verifyOTP on the repository and return false', () async {
      // Arrange
      when(mockOTPRepository.verifyOTP(testCode))
          .thenAnswer((_) async => false);

      // Act
      final result = await verifyOTP.call(testCode);

      // Assert
      expect(result, false);
      verify(mockOTPRepository.verifyOTP(testCode)).called(1);
    });

    test('should throw an exception if verifyOTP on the repository throws',
        () async {
      // Arrange
      when(mockOTPRepository.verifyOTP(testCode))
          .thenThrow(Exception('Error verifying OTP'));

      // Act & Assert
      expect(() => verifyOTP.call(testCode), throwsA(isA<Exception>()));
    });
  });
}
