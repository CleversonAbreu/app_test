import 'dart:async';

import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/auth/authentication/errors/auth_errors.dart';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../models/auth_model.dart';
import '../models/result_auth_model.dart';
import 'auth_datasource.dart';

class AuthDataSourceImpl implements AuthDatasource {
  final DioClient dioClient;

  AuthDataSourceImpl(this.dioClient);

  var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
    ),
  );

  @override
  Future<ResultAuthModel> auth(AuthModel authModel) async {
    logger.i('Info Log: Authenticating user with data: ${authModel.toJson()}');
    try {
      final response = await _authRequest(authModel);
      return ResultAuthModel.fromMap(response.data);
    } on DioException catch (dioError) {
      _handleDioError(dioError);
      rethrow;
    } catch (e) {
      logger.e('An unexpected error occurred: $e');
      throw AuthError(AuthErrorType.unknownError);
    }
  }

  Future<Response> _authRequest(AuthModel authModel) async {
    try {
      return await dioClient.dio.post(
        '/login',
        data: authModel.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  void _handleDioError(DioException dioError) {
    if (dioError.type == DioExceptionType.connectionTimeout ||
        dioError.type == DioExceptionType.receiveTimeout) {
      logger.e('Request timed out');
      throw AuthError(AuthErrorType.timeoutError);
    } else if (dioError.type == DioExceptionType.badResponse) {
      _handleBadResponse(dioError);
    } else {
      logger.e('Unexpected network error: $dioError.message');
      throw AuthError(AuthErrorType.networkError);
    }
  }

  void _handleBadResponse(DioException dioError) {
    final statusCode = dioError.response?.statusCode;
    final message = dioError.message;
    logger.e('Error Log: ${message}');

    if (statusCode != null) {
      if (statusCode == 401) {
        logger.e('Unauthorized access. $message');
        throw AuthError(AuthErrorType.unauthorized);
      } else if (statusCode == 500) {
        logger.e('Server error occurred. $message');
        throw AuthError(AuthErrorType.serverError);
      } else {
        logger.e('API returned an error. $message');
        throw AuthError(AuthErrorType.unknownError);
      }
    } else {
        logger.e('API returned an error. $message');
        throw AuthError(AuthErrorType.unknownError);
    }
  }
}
