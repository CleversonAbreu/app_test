enum OTPErrorType { timeoutError, networkError, incorrectOtpError, emailNotFoundError, generateOtpError,
                    failedSendOtpError, invalidOtpError, unknownError 
                  }

class OTPError implements Exception {
  final OTPErrorType type;

  OTPError(this.type);

  OTPErrorType? get errorType => type;
}
