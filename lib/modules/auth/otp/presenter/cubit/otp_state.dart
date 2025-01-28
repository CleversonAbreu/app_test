part of 'otp_cubit.dart';

@immutable
abstract class OTPState {}

class OTPInitialState extends OTPState {}

class OTPLoadingState extends OTPState {}

class OTPSentState extends OTPState {}

class OTPVerifiedState extends OTPState {}

class OTPCodeErrorState extends OTPState {}

class OTPErrorState extends OTPState {
  final OTPErrorType? errorType;

  OTPErrorState(this.errorType);
}