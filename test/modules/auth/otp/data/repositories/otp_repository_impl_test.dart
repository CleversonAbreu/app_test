import 'package:app_test/modules/auth/otp/data/datasources/otp_remote_datasource.dart';
import 'package:app_test/modules/auth/otp/data/repositories/otp_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'otp_repository_impl_test.mocks.dart';

@GenerateMocks([OTPRemoteDataSource])
void main() {
  late OTPRepositoryImpl repository;
  late MockOTPRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockOTPRemoteDataSource();
    repository = OTPRepositoryImpl(mockRemoteDataSource);
  });

  group('OTPRepositoryImpl', () {
    final String testEmail = 'test@example.com';
    final String testCode = '123456';

    test('should call sendOTP on the remote data source', () async {
      // Arrange
      when(mockRemoteDataSource.sendOTP(testEmail))
          .thenAnswer((_) async => Future.value());

      // Act
      await repository.sendOTP(testEmail);

      // Assert
      verify(mockRemoteDataSource.sendOTP(testEmail)).called(1);
    });

    test('should call verifyOTP on the remote data source', () async {
      // Arrange
      when(mockRemoteDataSource.verifyOTP(testCode))
          .thenAnswer((_) async => Future.value(true));

      // Act
      final result = await repository.verifyOTP(testCode);

      // Assert
      expect(result, true);
      verify(mockRemoteDataSource.verifyOTP(testCode)).called(1);
    });
  });
}
