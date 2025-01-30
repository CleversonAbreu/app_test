// ignore_for_file: deprecated_member_use

import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/auth/authentication/domain/errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:app_test/core/errors/app_exceptions.dart';
import 'package:app_test/modules/auth/authentication/data/datasources/auth_datasource_impl.dart';
import 'package:app_test/modules/auth/authentication/data/models/auth_model.dart';
import 'package:app_test/modules/auth/authentication/data/models/result_auth_model.dart';

import 'auth_datasource_impl_test.mocks.dart';

@GenerateMocks([DioClient])
void main() {
  late AuthDataSourceImpl dataSource;
  late MockDioClient mockDioClient;
  late Dio mockDio;

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = Dio();
    when(mockDioClient.dio).thenReturn(mockDio);
    dataSource = AuthDataSourceImpl(mockDioClient);
  });

  group('AuthDataSourceImpl', () {
    test('should return ResultAuthModel when Dio returns status code 200', () async {
      final responseData = [
        {'token': 'sample_token'}
      ];
      final response = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/login'),
      );
      when(mockDio.post('/login')).thenAnswer((_) async => response);

      final authModel = AuthModel(email: 'test@example.com', password: 'password');
      final result = await dataSource.auth(authModel);

      expect(result, isA<ResultAuthModel>());
      expect(result.token, 'sample_token');
    });

    test('should throw DataSourceError when Dio returns non-200 status code', () async {
      final response = Response(
        data: {},
        statusCode: 400,
        requestOptions: RequestOptions(path: '/login'),
      );
      when(mockDio.get('/login')).thenAnswer((_) async => response);

      final authModel = AuthModel(email: 'test@example.com', password: 'password');

      expect(() async => await dataSource.auth(authModel), throwsA(isA<DataSourceError>()));
    });

    test('should throw TimeoutException on connection timeout', () async {
      when(mockDio.get('/login')).thenThrow(DioError(
        requestOptions: RequestOptions(path: '/login'),
        type: DioErrorType.connectionTimeout,
      ));

      final authModel = AuthModel(email: 'test@example.com', password: 'password');

      expect(() async => await dataSource.auth(authModel), throwsA(isA<TimeoutException>()));
    });

    test('should throw ApiException on bad response', () async {
      when(mockDio.get('/login')).thenThrow(DioError(
        requestOptions: RequestOptions(path: '/login'),
        type: DioErrorType.badResponse,
        response: Response(
          statusCode: 500,
          requestOptions: RequestOptions(path: '/login'),
        ),
      ));

      final authModel = AuthModel(email: 'test@example.com', password: 'password');

      expect(() async => await dataSource.auth(authModel), throwsA(isA<ApiException>()));
    });

    test('should throw NetworkException on unexpected network error', () async {
      when(mockDio.get('/login')).thenThrow(DioError(
        requestOptions: RequestOptions(path: '/login'),
        type: DioErrorType.connectionError,
        error: 'Network error',
      ));

      final authModel = AuthModel(email: 'test@example.com', password: 'password');

      expect(() async => await dataSource.auth(authModel), throwsA(isA<NetworkException>()));
    });

    test('should throw UnknownException for unexpected errors', () async {
      when(mockDio.get('/login')).thenThrow(Exception('Unknown error'));

      final authModel = AuthModel(email: 'test@example.com', password: 'password');

      expect(() async => await dataSource.auth(authModel), throwsA(isA<UnknownException>()));
    });
  });
}
