enum SignUpErrorType {
  networkError,
  timeoutError,
  badRequest,
  unauthorized,
  forbidden,
  conflict,
  serverError,
  unknownError,
  invalidEmail,
  weakPassword,
  missingFields,
  parsingError,
  unexpectedError,
}

class SignUpError {
  SignUpError(this.type);
  SignUpErrorType type;
}