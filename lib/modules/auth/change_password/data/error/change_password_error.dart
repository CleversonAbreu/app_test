enum ChangePasswordErrorType  { timeoutError, networkError,  
                                  emailNotFoundError, unauthorized, 
                                  serverError,unknownError 
                                }

class ChangePasswordError implements Exception {
  final ChangePasswordErrorType type;

  ChangePasswordError(this.type);

  ChangePasswordErrorType? get errorType => type;
}
