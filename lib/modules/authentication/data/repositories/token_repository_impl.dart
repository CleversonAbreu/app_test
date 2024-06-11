import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/repositories/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  final FlutterSecureStorage _secureStorage =
      FlutterSecureStorage(aOptions: _getAndroidOptions());

  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  @override
  Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(key: 'token', value: token);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      final token = await _secureStorage.read(key: 'token');
      return token;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeToken() async {
    try {
      await _secureStorage.delete(key: 'token');
    } catch (e) {
      rethrow;
    }
  }
}
