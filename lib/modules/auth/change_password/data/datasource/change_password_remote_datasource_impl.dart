import 'dart:async';

import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/auth/change_password/data/datasource/change_password_remote_datasource.dart';
import 'package:app_test/modules/auth/change_password/data/error/change_password_error.dart';
import 'package:app_test/modules/auth/change_password/data/model/change_password_model.dart';
import 'package:app_test/modules/auth/change_password/domain/entities/change_password_entity.dart';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ChangePasswordRemoteDataSourceImpl implements ChangePasswordRemoteDataSource {
  final DioClient dioClient;

  ChangePasswordRemoteDataSourceImpl(this.dioClient);

  var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
    ),
  );

  @override
 Future<void> changePassword(ChangePasswordEntity params) async {
    final model = ChangePasswordModel.fromEntity(params);
    logger.i('Changing password for user: ${model.toJson()}');
    try {
      await _changePasswordRequest(model);
    } on DioException catch (dioError) {
      _handleDioError(dioError);
      rethrow;
    } catch (e) {
      logger.e('An unexpected error occurred: $e');
      throw ChangePasswordError(ChangePasswordErrorType.unknownError);
    }
  }

  Future<Response> _changePasswordRequest(ChangePasswordModel model) async {
    try {
      return await dioClient.dio.post(
        '/users/change-password',
        data: model.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  void _handleDioError(DioException dioError) {
    if (dioError.type == DioExceptionType.connectionTimeout ||
        dioError.type == DioExceptionType.receiveTimeout) {
      logger.e('Request timed out');
      throw ChangePasswordError(ChangePasswordErrorType.timeoutError);
    } else if (dioError.type == DioExceptionType.badResponse) {
      _handleBadResponse(dioError);
    } else {
      logger.e('Unexpected network error: ${dioError.message}');
      throw ChangePasswordError(ChangePasswordErrorType.networkError);
    }
  }

  void _handleBadResponse(DioException dioError) {
    final statusCode = dioError.response?.statusCode;
    final message = dioError.message;
    logger.e('Error Log: $message');

    if (statusCode != null) {
      if (statusCode == 401) {
        logger.e('Unauthorized access. $message');
        throw ChangePasswordError(ChangePasswordErrorType.unauthorized);
      } else if (statusCode == 500) {
        logger.e('Server error occurred. $message');
        throw ChangePasswordError(ChangePasswordErrorType.serverError);
      } else {
        logger.e('API returned an error. $message');
        throw ChangePasswordError(ChangePasswordErrorType.unknownError);
      }
    } else {
      logger.e('API returned an error. $message');
      throw ChangePasswordError(ChangePasswordErrorType.unknownError);
    }
  }
}
