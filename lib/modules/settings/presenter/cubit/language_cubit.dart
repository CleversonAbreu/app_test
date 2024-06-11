import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en', 'US'));

  void toggleLanguage() {
    if (state.languageCode == 'en') {
      emit(const Locale('pt', 'BR'));
    } else {
      emit(const Locale('en', 'US'));
    }
  }
}
