import 'dart:async';

import 'package:app_test/core/errors/app_exceptions.dart';
import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/auth/otp/errors/otp_error.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'otp_remote_datasource.dart';

class OTPRemoteDataSourceImpl implements OTPRemoteDataSource {
  final DioClient dioClient;

  OTPRemoteDataSourceImpl(this.dioClient);

  var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
    ),
  );

  @override
  Future<void> sendOTP(String email, String typeGenerate) async {
    logger.i('Info Log: email: ${email}');
    try {
      await _sendOtpRequest(email, typeGenerate);
      // ignore: deprecated_member_use
    } on DioError catch (dioError) {
      _handleDioError(dioError);
    } catch (e) {
      throw UnknownException('An unexpected error occurred: $e');
    }
  }

  Future<Response> _sendOtpRequest(String email, String typeGenerate) async {
    logger.i('Info Log: email: ${email}');
    try {
      final response = await dioClient.dio.post(
        '/otp/generate',
        data: {
          "phone_or_email": email,
          "type_generate": typeGenerate,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> verifyOTP(String email, String code) async {
    logger.i('Info Log: email: ${email} | code: ${code}');
    try {
      await _verifyOtpRequest(email, code);
      return true;
      // ignore: deprecated_member_use
    } on DioError catch (dioError) {
      _handleDioError(dioError);
      return false;
    } catch (e) {
      logger.e('An unexpected error occurred: $e');
      throw OTPError(OTPErrorType.unknownError);
    }
  }

  Future<Response> _verifyOtpRequest(String email, String code) async {
    logger.i('Info Log: email: ${email} | code: ${code}');
    try {
      final response = await dioClient.dio.post(
        '/otp/validate',
        data: {
          "phone_or_email": email,
          "otp_code": code,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // ignore: deprecated_member_use
  void _handleDioError(DioError dioError) {
    if (dioError.type == DioExceptionType.connectionTimeout ||
        dioError.type == DioExceptionType.receiveTimeout) {
      throw OTPError(OTPErrorType.timeoutError);
    } else if (dioError.type == DioExceptionType.badResponse) {
      _handleBadResponse(dioError);
    } else {
      throw OTPError(OTPErrorType.networkError);
    }
  }

  // ignore: deprecated_member_use
  void _handleBadResponse(DioError dioError) {
    final statusCode = dioError.response?.statusCode;
    final errorData = dioError.response?.data;
    final message = dioError.message;
    logger.e('Error Log: ${message}');

    if (statusCode != null) {
      if (statusCode == 404 && errorData['error_type'] == 'EMAIL_NOT_FOUND') {
        throw OTPError(OTPErrorType.emailNotFoundError);
      } else if (statusCode == 500 &&
          errorData['error_type'] == 'FAILED_TO_GENERATE_OTP') {
        throw OTPError(OTPErrorType.generateOtpError);
      } else if (statusCode == 503 &&
          errorData['error_type'] == 'FAILED_TO_SEND_OTP') {
        throw OTPError(OTPErrorType.failedSendOtpError);
      } else if (statusCode == 400 &&
          errorData['error_type'] == 'INVALID_OTP') {
        throw OTPError(OTPErrorType.invalidOtpError);
      } else if (statusCode == 409 &&
          errorData['error_type'] == 'EMAIL_ALREADY_EXISTS') {
        throw OTPError(OTPErrorType.emailAlreadyExists);
      } else {
        throw OTPError(OTPErrorType.unknownError);
      }
    } else {
      throw OTPError(OTPErrorType.unknownError);
    }
  }
}
