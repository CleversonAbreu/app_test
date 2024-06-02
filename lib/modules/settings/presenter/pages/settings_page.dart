import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/language_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubit/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final languageCubit = context.read<LanguageCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.darkMode),
            trailing: Switch(
              value: themeCubit.state == ThemeState.dark,
              onChanged: (value) {
                themeCubit.toggleTheme();
              },
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.language),
            trailing: Switch(
              value: languageCubit.state == const Locale('pt', 'BR'),
              onChanged: (value) {
                languageCubit.toggleLanguage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
