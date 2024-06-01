import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum ThemeState { light, dark }

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light);

  void toggleTheme() {
    if (state == ThemeState.light) {
      emit(ThemeState.dark);
    } else {
      emit(ThemeState.light);
    }
  }

  ThemeData get themeData {
    return state == ThemeState.light
        ? ThemeData.light()
        : ThemeData.dark();
  }
}