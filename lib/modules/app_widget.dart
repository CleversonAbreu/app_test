import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';

import 'app_router.dart';
import 'auth/authentication/presenter/cubit/auth_cubit.dart';
import 'settings/presenter/cubit/language_cubit.dart';
import 'settings/presenter/cubit/theme_cubit.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  bool _isLoading = true;
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    _appRouter = AppRouter(_secureStorage);
    await _appRouter.init();
    setState(() {
      _isLoading = false;
    });
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GetIt.instance<ThemeCubit>(),
        ),
        BlocProvider(
          create: (_) => GetIt.instance<LanguageCubit>(),
        ),
        BlocProvider(
          create: (_) => GetIt.instance<AuthCubit>(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              final themeCubit = BlocProvider.of<ThemeCubit>(context);

              return MaterialApp.router(
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
                routerConfig: _appRouter.router,
              );
            },
          );
        },
      ),
    );
  }
}
