import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/auth/signup/data/datasources/signup_remote_datasource.dart';
import 'package:app_test/modules/auth/signup/data/models/signup_model.dart';
import 'package:app_test/modules/auth/signup/errors/signup_error.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:dartz/dartz.dart';


class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final DioClient dioClient;

  SignUpRemoteDataSourceImpl(this.dioClient);

  var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
    ),
  );

  @override
  Future<Either<SignUpError, SignUpModel>> signUp(SignUpModel model) async {
    logger.i('Info Log: Registering user with data: ${model.toJson()}');
    
    final result = await _signUpRequest(model);
    
    return result.fold(
      (error) => Left(error),
      (response) {
        try {
          final signupModel = SignUpModel.fromMap(response.data['data']);
          return Right(signupModel);
        } catch (e) {
          logger.e('Error parsing response: $e');
          return Left(SignUpError(SignUpErrorType.parsingError));
        }
      },
    );
  }
  
  Future<Either<SignUpError, Response>> _signUpRequest(SignUpModel signUpModel) async {
    try {
      final response = await dioClient.dio.post(
        '/users',
        data: signUpModel.toJson(),
      );
      return Right(response);
    } on DioException catch (dioError) {
      return Left(_handleDioError(dioError));
    } catch (e) {
      logger.e('An unexpected error occurred: $e');
      return Left(SignUpError(SignUpErrorType.unknownError));
    }
  }

  SignUpError _handleDioError(DioException dioError) {
    if (dioError.type == DioExceptionType.connectionTimeout ||
        dioError.type == DioExceptionType.receiveTimeout) {
      logger.e('Request timed out');
      return SignUpError(SignUpErrorType.timeoutError);
    } else if (dioError.type == DioExceptionType.badResponse) {
      return _handleBadResponse(dioError);
    } else {
      logger.e('Unexpected network error: ${dioError.message}');
      return SignUpError(SignUpErrorType.networkError);
    }
  }

  SignUpError _handleBadResponse(DioException dioError) {
    final statusCode = dioError.response?.statusCode;
    final message = dioError.message;
    logger.e('Error Log: $message');

    if (statusCode == 401) {
      logger.e('Unauthorized access. $message');
      return SignUpError(SignUpErrorType.unauthorized);
    } else if (statusCode == 500) {
      logger.e('Server error occurred. $message');
      return SignUpError(SignUpErrorType.serverError);
    } else {
      logger.e('API returned an error. $message');
      return SignUpError(SignUpErrorType.unknownError);
    }
  }
}
