import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/auth_model.dart';
import '../../domain/repositories/token_repository.dart';
import '../../domain/usecases/result_auth_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.usecase, this.tokenRepository) : super(AuthInitial());

  final _prefs = SharedPreferences.getInstance();
  final ResultAuthUsecase usecase;
  final TokenRepository tokenRepository;

  Future<void> auth(String email, String password, bool rememberMe) async {
    AuthModel authModel = AuthModel(email: email, password: password);
    emit(AuthLoading());

    try {
      final result = await usecase(authModel);
      result.fold(
        (failure) {
          if (kDebugMode) {
            print('AuthUsecase Error : ${failure.message}');
          }
          emit(const AuthError('authError'));
        },
        (success) async {
          if (rememberMe) {
            await _prefs.then((prefs) {
              prefs.setStringList('credentials', [email, password]);
            });
          } else {
            await clearSavedCredentials();
          }
          if (kDebugMode) {
            print('Token: ${success.token}');
          }
          try {
            await tokenRepository.saveToken(success.token);
            emit(AuthAuthenticated());
          } catch (e) {
            if (kDebugMode) {
              print('Error saving token: $e');
            }
            emit(const AuthError('tokenSaveError'));
          }
        },
      );
    } catch (e) {
      emit(const AuthError('authError'));
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

  Future<List<String>?> getSavedCredentials() async {
    return await _prefs.then((prefs) => prefs.getStringList('credentials'));
  }

  Future<void> clearSavedCredentials() async {
    await _prefs.then((prefs) {
      prefs.remove('credentials');
    });
  }

  void validate(
      BuildContext context,
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController,
      bool rememberMe) {
    if (formKey.currentState?.validate() ?? false) {
      final email = emailController.text;
      final password = passwordController.text;
      context.read<AuthCubit>().auth(email, password, rememberMe);
    }
  }
}
