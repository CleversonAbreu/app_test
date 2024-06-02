abstract class LoginFailure implements Exception {}

class InvalidCredentials extends LoginFailure {}

class DataSourceError extends LoginFailure {
  final String? message;

  DataSourceError({this.message});
}
