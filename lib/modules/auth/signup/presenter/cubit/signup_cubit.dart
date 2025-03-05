
import 'package:app_test/modules/auth/signup/data/models/signup_model.dart';
import 'package:app_test/modules/auth/signup/domain/entities/signup_entity.dart';
import 'package:app_test/modules/auth/signup/errors/signup_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../domain/usecases/signup_usecase.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUsecase signUpUsecase;

  SignUpCubit(this.signUpUsecase) : super(SignUpInitial());

  Future<void> registerUser(SignUpModel model) async {
    emit(SignUpLoading());

    final Either<SignUpError, SignUpEntity> result = await signUpUsecase(model);

    result.fold(
      (error) => emit(SignUpFailure(error)),
      (user) => emit(SignUpSuccess(user)),
    );
  }
}
