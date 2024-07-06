import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/settings_usecase.dart';

class LanguageCubit extends Cubit<Locale> {
  final SettingsUseCase usecase;

  LanguageCubit(this.usecase) : super(const Locale('en', 'US')) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final localeString = await usecase.fetchLocale();
    if (localeString != null) {
      emit(Locale(localeString.split('_').first, localeString.split('_').last));
    }
  }

  void toggleLanguage() async {
    if (state.languageCode == 'en') {
      await usecase.updateLocale('pt_BR');
      emit(const Locale('pt', 'BR'));
    } else {
      await usecase.updateLocale('en_US');
      emit(const Locale('en', 'US'));
    }
  }
}
