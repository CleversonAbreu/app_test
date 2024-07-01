import 'package:app_test/modules/auth/otp/data/datasources/otp_remote_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:email_otp/email_otp.dart';
import 'otp_remote_datasource_test.mocks.dart';

@GenerateMocks([EmailOTP])
void main() {
  late OTPRemoteDataSourceImpl datasource;
  late MockEmailOTP mockEmailOTP;

  setUp(() {
    mockEmailOTP = MockEmailOTP();
    datasource = OTPRemoteDataSourceImpl(mockEmailOTP);
  });

  group('OTPRemoteDataSourceImpl', () {
    final String testEmail = 'test@example.com';
    final String testCode = '123456';

    test('should send OTP', () async {
      // Arrange
      when(mockEmailOTP.setConfig(
        appEmail: anyNamed('appEmail'),
        appName: anyNamed('appName'),
        userEmail: anyNamed('userEmail'),
        otpLength: anyNamed('otpLength'),
        otpType: anyNamed('otpType'),
      )).thenReturn(null);
      when(mockEmailOTP.sendOTP()).thenAnswer((_) async => true);

      // Act
      await datasource.sendOTP(testEmail);

      // Assert
      verify(mockEmailOTP.setConfig(
        appEmail: testEmail,
        appName: 'Base App',
        userEmail: testEmail,
        otpLength: 6,
        otpType: OTPType.digitsOnly,
      )).called(1);
      verify(mockEmailOTP.sendOTP()).called(1);
    });

    test('should verify OTP', () async {
      // Arrange
      when(mockEmailOTP.verifyOTP(otp: testCode)).thenAnswer((_) async => true);

      // Act
      final result = await datasource.verifyOTP(testCode);

      // Assert
      expect(result, true);
      verify(mockEmailOTP.verifyOTP(otp: testCode)).called(1);
    });
  });
}
