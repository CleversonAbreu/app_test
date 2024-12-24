// ignore_for_file: deprecated_member_use

import 'package:app_test/core/errors/app_exceptions.dart';
import 'package:app_test/core/network/dio_client.dart';
import 'package:app_test/modules/user/profile/data/datasources/profile_remote_datasource.dart';
import 'package:app_test/modules/user/profile/data/models/profile_model.dart';

import 'package:dio/dio.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient dioClient;

  ProfileRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await dioClient.dio.get('/profile');
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ApiException('Error fetching profile: ${response.statusCode}');
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
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async => throw UnimplementedError();
}
