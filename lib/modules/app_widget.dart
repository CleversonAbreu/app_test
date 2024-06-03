import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'authentication/presenter/cubit/auth_cubit.dart';
import 'settings/presenter/cubit/language_cubit.dart';
import 'settings/presenter/cubit/theme_cubit.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppWidget extends StatelessWidget {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _secureStorage.read(key: 'token'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text(AppLocalizations.of(context)!.errorLoadingToken);
        }
        final token = snapshot.data;

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ThemeCubit()),
            BlocProvider(create: (context) => LanguageCubit()),
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
                        routeInformationProvider:
                            PlatformRouteInformationProvider(
                          initialRouteInformation: RouteInformation(
                              // ignore: deprecated_member_use
                              location: token != null ? '/home' : '/login'),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
