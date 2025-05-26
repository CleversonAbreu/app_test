import 'package:app_test/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:app_test/l10n/localization.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => GoRouter.of(context).go(AppRoutes.settings),
          ),
        ],
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)!.welcomeMessage),
      ),
    );
  }
}
