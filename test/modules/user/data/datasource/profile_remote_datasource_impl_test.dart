// ignore_for_file: deprecated_member_use

import 'package:app_test/core/network/dio_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:app_test/core/errors/app_exceptions.dart';
import 'package:app_test/modules/user/profile/data/models/profile_model.dart';
import 'package:app_test/modules/user/profile/data/datasources/profile_remote_datasource_impl.dart';

import 'profile_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late ProfileRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = ProfileRemoteDataSourceImpl(mockDio as DioClient);
  });

  group('ProfileRemoteDataSourceImpl', () {
    test('should return a ProfileModel when Dio returns status code 200', () async {
      final responseData = {'id': 1, 'name': 'John Doe', 'email': 'john.doe@example.com'};
      final response = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/profile'),
      );
      when(mockDio.get('/profile')).thenAnswer((_) async => response);

      final result = await dataSource.getProfile();

      expect(result, isA<ProfileModel>());
      expect(result.name, 'John Doe');
      expect(result.email, 'john.doe@example.com');
    });

    test('should throw ApiException when Dio returns non-200 status code', () async {
      final response = Response(
        data: {},
        statusCode: 400,
        requestOptions: RequestOptions(path: '/profile'),
      );
      when(mockDio.get('/profile')).thenAnswer((_) async => response);

      expect(() async => await dataSource.getProfile(), throwsA(isA<ApiException>()));
    });

    test('should throw TimeoutException on connection timeout', () async {
      when(mockDio.get('/profile')).thenThrow(DioError(
        requestOptions: RequestOptions(path: '/profile'),
        type: DioErrorType.connectionTimeout,
      ));

      expect(() async => await dataSource.getProfile(), throwsA(isA<TimeoutException>()));
    });

    test('should throw NetworkException on network error', () async {
      when(mockDio.get('/profile')).thenThrow(DioError(
        requestOptions: RequestOptions(path: '/profile'),
        type: DioErrorType.connectionError,
        error: 'Network error',
      ));

      expect(() async => await dataSource.getProfile(), throwsA(isA<NetworkException>()));
    });

    test('should throw UnknownException for unknown errors', () async {
      when(mockDio.get('/profile')).thenThrow(Exception('Unknown error'));

      expect(() async => await dataSource.getProfile(), throwsA(isA<UnknownException>()));
    });
  });
}
