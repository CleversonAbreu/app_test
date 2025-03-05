import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient(FlutterSecureStorage secureStorage) : dio = Dio() {
    dio.options.baseUrl = 'http://192.168.1.3:8080/api/';
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    dio.interceptors.add(AuthInterceptor(secureStorage));
  }
}
