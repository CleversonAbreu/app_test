part of 'otp_cubit.dart';

@immutable
abstract class OTPState {}

class OTPInitial extends OTPState {}

class OTPLoading extends OTPState {}

class OTPSent extends OTPState {}

class OTPVerified extends OTPState {}

class OTPCodeError extends OTPState {}

class OTPError extends OTPState {
  final String message;

  OTPError(this.message);
}
