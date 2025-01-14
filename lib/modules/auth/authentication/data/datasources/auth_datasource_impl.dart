// ignore_for_file: deprecated_member_use

import 'package:app_test/core/errors/app_exceptions.dart';
import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/auth/authentication/domain/errors/errors.dart';
import 'package:dio/dio.dart';
import '../models/auth_model.dart';
import '../models/result_auth_model.dart';
import 'auth_datasource.dart';

class AuthDataSourceImpl implements AuthDatasource {
  final DioClient dioClient;

  AuthDataSourceImpl(this.dioClient);

  @override
  Future<ResultAuthModel> auth(AuthModel authModel) async {
    try {
      final response = await dioClient.dio.post(
        '/login',
        data: authModel.toJson(),
      );
      if (response.statusCode == 200) {
        return ResultAuthModel.fromMap(response.data);
      } else {
        throw DataSourceError();
      }
    } on DioError catch (dioError) {
      if (dioError.type == DioErrorType.connectionTimeout || dioError.type == DioErrorType.receiveTimeout) {
        throw TimeoutException('Request timed out. Please try again later.');
      } else if (dioError.type == DioErrorType.badResponse) {
        throw ApiException('API returned an error: ${dioError.response?.statusCode}');
      } else {
        throw NetworkException('Unexpected network error: ${dioError.message}');
      }
    } catch (e) {
      throw UnknownException('An unexpected error occurred: $e');
    }
  }s
}
