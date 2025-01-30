
import 'package:app_test/modules/auth/change_password/data/error/change_password_error.dart';

abstract class ChangePasswordState {}

class ChangePasswordInitialState extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordSuccessState extends ChangePasswordState {}

class ChangePasswordErrorState implements ChangePasswordState {
    final ChangePasswordErrorType? errorType;

  ChangePasswordErrorState(this.errorType);
}
