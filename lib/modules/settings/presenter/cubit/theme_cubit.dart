import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/settings_usecase.dart';

enum ThemeState { light, dark }

class ThemeCubit extends Cubit<ThemeState> {
  final SettingsUseCase usecase;

  ThemeCubit(this.usecase) : super(ThemeState.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final isDarkMode = await usecase.fetchTheme() ?? false;
    emit(isDarkMode ? ThemeState.dark : ThemeState.light);
  }

  void toggleTheme() async {
    if (state == ThemeState.light) {
      await usecase.updateTheme(true);
      emit(ThemeState.dark);
    } else {
      await usecase.updateTheme(false);
      emit(ThemeState.light);
    }
  }

  ThemeData get themeData {
    return state == ThemeState.light ? ThemeData.light() : ThemeData.dark();
  }
}
