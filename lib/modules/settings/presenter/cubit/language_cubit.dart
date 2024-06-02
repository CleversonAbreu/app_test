import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(Locale('en', 'US'));

  void toggleLanguage() {
    if (state.languageCode == 'en') {
      emit(Locale('pt', 'BR'));
    } else {
      emit(Locale('en', 'US'));
    }
  }
}
