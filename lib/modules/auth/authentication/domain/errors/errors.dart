abstract class AuthFailure implements Exception {
  String get message; // Adiciona o getter 'message'
}

class InvalidCredentials extends AuthFailure {
  @override
  String get message => 'Invalid credentials';
}

class DataSourceError extends AuthFailure {
  final String? _message;

  DataSourceError({String? message}) : _message = message;

  @override
  String get message => _message ?? 'An unknown data source error occurred';
}
