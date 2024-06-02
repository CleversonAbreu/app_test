import 'package:bloc/bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      await Future.delayed(Duration(seconds: 2));

      if (email == 'test@example.com' && password == 'password123') {
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError('invalidCredentials'));
      }
    } catch (e) {
      emit(const AuthError('loginError'));
    }
  }

  void emitError(String errorMessage) {
    emit(AuthError(errorMessage));
  }
}
