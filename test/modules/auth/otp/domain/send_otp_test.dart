import 'package:app_test/modules/auth/otp/domain/repositories/otp_repository.dart';
import 'package:app_test/modules/auth/otp/domain/usecases/send_otp_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'send_otp_test.mocks.dart';

@GenerateMocks([OTPRepository])
void main() {
  late SendOTP sendOTP;
  late MockOTPRepository mockOTPRepository;

  setUp(() {
    mockOTPRepository = MockOTPRepository();
    sendOTP = SendOTP(mockOTPRepository);
  });

  group('SendOTP', () {
    final String testEmail = 'test@example.com';

    test('should call sendOTP on the repository', () async {
      // Arrange
      when(mockOTPRepository.sendOTP(testEmail))
          .thenAnswer((_) async => Future.value());

      // Act
      await sendOTP.call(testEmail);

      // Assert
      verify(mockOTPRepository.sendOTP(testEmail)).called(1);
    });

    test('should throw an exception if sendOTP on the repository throws',
        () async {
      // Arrange
      when(mockOTPRepository.sendOTP(testEmail))
          .thenThrow(Exception('Error sending OTP'));

      // Act & Assert
      expect(() => sendOTP.call(testEmail), throwsA(isA<Exception>()));
    });
  });
}
