enum AuthErrorType { timeoutError, networkError, invalidCredentials, unauthorized, serverError, authError ,  unknownError }

class AuthError implements Exception {
  final AuthErrorType type;

  AuthError(this.type);

  AuthErrorType? get errorType => type;
}
