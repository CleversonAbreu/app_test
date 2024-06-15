// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';

// enum ThemeState { light, dark }

// class ThemeCubit extends Cubit<ThemeState> {
//   ThemeCubit() : super(ThemeState.light);

//   void toggleTheme() {
//     if (state == ThemeState.light) {
//       emit(ThemeState.dark);
//     } else {
//       emit(ThemeState.light);
//     }
//   }

//   ThemeData get themeData {
//     return state == ThemeState.light
//         ? ThemeData.light()
//         : ThemeData.dark();
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../data/repositories/settings_repository.dart';

enum ThemeState { light, dark }

class ThemeCubit extends Cubit<ThemeState> {
  final SettingsRepository settingsRepository;

  ThemeCubit(this.settingsRepository) : super(ThemeState.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final isDarkMode = await settingsRepository.getTheme() ?? false;
    emit(isDarkMode ? ThemeState.dark : ThemeState.light);
  }

  void toggleTheme() async {
    if (state == ThemeState.light) {
      await settingsRepository.saveTheme(true);
      emit(ThemeState.dark);
    } else {
      await settingsRepository.saveTheme(false);
      emit(ThemeState.light);
    }
  }

  ThemeData get themeData {
    return state == ThemeState.light ? ThemeData.light() : ThemeData.dark();
  }
}
