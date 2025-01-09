class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class NoInternetException extends AppException {
  NoInternetException(String message) : super(message);
}

class ApiException extends AppException {
  ApiException(String message) : super(message);
}

class TimeoutException extends AppException {
  TimeoutException(String message) : super(message);
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message);
}

class UnknownException extends AppException {
  UnknownException(String message) : super(message);
}
