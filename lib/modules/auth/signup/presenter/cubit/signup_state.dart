import 'package:app_test/modules/auth/signup/domain/entities/signup_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:app_test/modules/auth/signup/errors/signup_error.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final SignUpEntity user;

  const SignUpSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class SignUpFailure extends SignUpState {
  final SignUpError error;

  const SignUpFailure(this.error);

  @override
  List<Object?> get props => [error];
}
