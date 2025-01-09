import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient(FlutterSecureStorage secureStorage) : dio = Dio() {
    dio.options.baseUrl = 'https://apptest.free.beeceptor.com/';
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    dio.interceptors.add(AuthInterceptor(secureStorage));
  }
}
