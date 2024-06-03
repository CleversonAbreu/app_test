import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../authentication/presenter/cubit/auth_cubit.dart';
import '../../../authentication/presenter/cubit/auth_state.dart';
import '../cubit/language_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../cubit/theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
      body: Column(
        children: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return ListTile(
                title: Text(AppLocalizations.of(context)!.darkMode),
                trailing: Switch(
                  value: themeState == ThemeState.dark,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),
              );
            },
          ),
          BlocBuilder<LanguageCubit, Locale>(
            builder: (context, locale) {
              return ListTile(
                title: Text(AppLocalizations.of(context)!.language),
                trailing: Switch(
                  value: locale == const Locale('pt', 'BR'),
                  onChanged: (value) {
                    context.read<LanguageCubit>().toggleLanguage();
                  },
                ),
              );
            },
          ),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              return ListTile(
                title: Text(AppLocalizations.of(context)!.logout),
                onTap: () async {
                  await storage.delete(key: 'token');
                  // ignore: use_build_context_synchronously
                  context.read<AuthCubit>().logout();
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, '/login');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
