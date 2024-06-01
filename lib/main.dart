import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'modules/settings/presenter/views/cubit/language_cubit.dart';
import 'modules/home/presenter/views/home_page.dart';

import 'modules/settings/presenter/views/cubit/theme_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => LanguageCubit()),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              final themeCubit = context.read<ThemeCubit>();
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeCubit.themeData,
                locale: locale,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('pt'),
                ],
                home: HomePage(),
              );
            },
          );
        },
      ),
    );
  }
}
