import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'authentication/presenter/cubit/auth_cubit.dart';
import 'settings/data/repositories/settings_repository.dart';
import 'settings/presenter/cubit/language_cubit.dart';
import 'settings/presenter/cubit/theme_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/scheduler.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  String? _token;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Use SchedulerBinding to delay the removal of the splash screen
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _loadToken();
      FlutterNativeSplash.remove();
    });
  }

  Future<void> _loadToken() async {
    try {
      _token = await _secureStorage.read(key: 'token');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _checkToken() async {
    setState(() {
      _isLoading = true;
    });
    await _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    _checkToken();

    final settingsRepository = SettingsRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(settingsRepository),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(settingsRepository),
        ),
        BlocProvider(
          create: (context) => AuthCubit(Modular.get(), Modular.get()),
        ),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              final themeCubit = BlocProvider.of<ThemeCubit>(context);
              return ScreenUtilInit(
                designSize: const Size(360, 690),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (_, child) {
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
                    routeInformationParser: Modular.routeInformationParser,
                    routerDelegate: Modular.routerDelegate,
                    routeInformationProvider: PlatformRouteInformationProvider(
                      initialRouteInformation: RouteInformation(
                        // location: _token != null ? '/home' : '/auth',
                        // ignore: deprecated_member_use
                        location: _token != null ? '/home' : '/onboarding',
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
