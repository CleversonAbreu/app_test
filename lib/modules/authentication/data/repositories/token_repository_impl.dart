import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/repositories/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  @override
  Future<void> removeToken() async {
    await _secureStorage.delete(key: 'token');
  }
}
