import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient(FlutterSecureStorage secureStorage) : dio = Dio() {
    // Dio standard configurations
    dio.options.baseUrl = 'http://192.168.1.5:8080/api/v1/';
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.followRedirects = true;
    dio.options.validateStatus = (status) {
      // Allows redirections and avoids failures in 3xx codes
      return status != null && status < 500;
    };

    // Default header for requests
    dio.options.headers = {
      'Content-Type': 'application/json',
      "Accept": "application/json",
    };

    // Add authentication interceptor
    dio.interceptors.add(AuthInterceptor(secureStorage));

    // Add a log interceptor for debugging
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }
}
