import 'package:app_test/modules/auth/change_password/data/error/change_password_error.dart';
import 'package:app_test/modules/auth/change_password/domain/entities/change_password_entity.dart';
import 'package:app_test/modules/auth/change_password/domain/usecases/change_password_usecase.dart';
import 'package:app_test/modules/auth/change_password/presenter/cubit/change_password_state.dart';
import 'package:bloc/bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit(this.changePasswordUseCase) : super(ChangePasswordInitialState());

  Future<void> changePassword(String email, String newPassword) async {
    emit(ChangePasswordLoadingState());
    try {
      await changePasswordUseCase(ChangePasswordEntity(
        email: email,
        newPassword: newPassword,
      ));
      emit(ChangePasswordSuccessState());
    } catch (e) {
      emit(ChangePasswordErrorState(ChangePasswordErrorType.unknownError));
    }
  }
}
