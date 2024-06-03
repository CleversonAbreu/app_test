// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import '../../data/models/login_model.dart';
import '../../domain/repositories/token_repository.dart';
import '../../domain/usecases/result_login_usecase.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.usecase, this.tokenRepository) : super(AuthInitial());

  final ResultLoginUsecase usecase;
  final TokenRepository tokenRepository;

  Future<void> login(String email, String password) async {
    LoginModel loginModel = LoginModel(email: email, password: password);
    emit(AuthLoading());

    try {
      final result = await usecase(loginModel);
      result.fold(
        (failure) {
          if (kDebugMode) {
            print('LoginUsecase Error : ${failure.message}');
          }
          emit(const AuthError('loginError'));
        },
        (success) async {
          if (kDebugMode) {
            print('Token: ${success.token}');
          }
          await tokenRepository.saveToken(success.token);
          emit(AuthAuthenticated());
        },
      );
    } catch (e) {
      emit(const AuthError('loginError'));
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await tokenRepository.removeToken();
      emit(AuthInitial());
    } catch (e) {
      emit(const AuthError('logoutError'));
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
