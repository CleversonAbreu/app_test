import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/auth/otp/data/datasources/otp_remote_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'otp_remote_datasource_test.mocks.dart';
import 'package:dio/dio.dart';
import 'package:app_test/modules/auth/otp/errors/otp_error.dart';

@GenerateMocks([DioClient])
void main() {
  late OTPRemoteDataSourceImpl datasource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    datasource = OTPRemoteDataSourceImpl(mockDioClient);
  });

  group('OTPRemoteDataSourceImpl', () {
    final String testEmail = 'test@example.com';
    final String testCode = '123456';

    test('should send OTP successfully', () async {
      // Arrange
      when(mockDioClient.dio.post(
        '/otp/generate',
        data: {"phone_or_email": testEmail},
      )).thenAnswer((_) async => Response(
            statusCode: 200,
            data: {"message": "OTP sent successfully"},
            requestOptions: RequestOptions(path: '/otp/generate'),
          ));

      // Act
      await datasource.sendOTP(testEmail);

      // Assert
      verify(mockDioClient.dio.post(
        '/otp/generate',
        data: {"phone_or_email": testEmail},
      )).called(1);
    });

    test('should throw OTPError when DioError occurs on sendOTP', () async {
      // Arrange
      when(mockDioClient.dio.post(
        '/otp/generate',
        data: {"phone_or_email": testEmail},
      // ignore: deprecated_member_use
      )).thenThrow(DioError(
        requestOptions: RequestOptions(path: '/otp/generate'),
        error: 'Network error',
        type: DioExceptionType.connectionTimeout,
      ));

      // Act & Assert
      expect(() => datasource.sendOTP(testEmail), throwsA(isA<OTPError>()));
    });

    test('should verify OTP successfully', () async {
      // Arrange
      when(mockDioClient.dio.post(
        '/otp/validate',
        data: {"phone_or_email": testEmail, "otp_code": testCode},
      )).thenAnswer((_) async => Response(
            statusCode: 200,
            data: {"message": "OTP verified successfully"},
            requestOptions: RequestOptions(path: '/otp/validate'),
          ));

      // Act
      final result = await datasource.verifyOTP(testEmail, testCode);

      // Assert
      expect(result, true);
      verify(mockDioClient.dio.post(
        '/otp/validate',
        data: {"phone_or_email": testEmail, "otp_code": testCode},
      )).called(1);
    });

    test('should throw OTPError when DioError occurs on verifyOTP', () async {
      // Arrange
      when(mockDioClient.dio.post(
        '/otp/validate',
        data: {"phone_or_email": testEmail, "otp_code": testCode},
      // ignore: deprecated_member_use
      )).thenThrow(DioError(
        requestOptions: RequestOptions(path: '/otp/validate'),
        error: 'Network error',
        type: DioExceptionType.connectionTimeout,
      ));

      // Act & Assert
      expect(() => datasource.verifyOTP(testEmail, testCode), throwsA(isA<OTPError>()));
    });

    test('should handle specific OTP errors on verifyOTP', () async {
      // Arrange
      when(mockDioClient.dio.post(
        '/otp/validate',
        data: {"phone_or_email": testEmail, "otp_code": testCode},
      // ignore: deprecated_member_use
      )).thenThrow(DioError(
        requestOptions: RequestOptions(path: '/otp/validate'),
        response: Response(
          statusCode: 400,
          data: {'error_type': 'INVALID_OTP'},
          requestOptions: RequestOptions(path: '/otp/validate'),
        ),
        type: DioExceptionType.badResponse,
      ));

      // Act & Assert
      expect(() => datasource.verifyOTP(testEmail, testCode),
          throwsA(isA<OTPError>().having((e) => e.type, 'error type', OTPErrorType.invalidOtpError)));
    });
  });
}
