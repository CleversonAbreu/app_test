// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/material.dart';

// class LanguageCubit extends Cubit<Locale> {
//   LanguageCubit() : super(const Locale('en', 'US'));

//   void toggleLanguage() {
//     if (state.languageCode == 'en') {
//       emit(const Locale('pt', 'BR'));
//     } else {
//       emit(const Locale('en', 'US'));
//     }
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../data/repositories/settings_repository.dart';

class LanguageCubit extends Cubit<Locale> {
  final SettingsRepository settingsRepository;

  LanguageCubit(this.settingsRepository) : super(const Locale('en', 'US')) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final localeString = await settingsRepository.getLocale();
    if (localeString != null) {
      emit(Locale(localeString.split('_').first, localeString.split('_').last));
    }
  }

  void toggleLanguage() async {
    if (state.languageCode == 'en') {
      await settingsRepository.saveLocale('pt_BR');
      emit(const Locale('pt', 'BR'));
    } else {
      await settingsRepository.saveLocale('en_US');
      emit(const Locale('en', 'US'));
    }
  }
}
