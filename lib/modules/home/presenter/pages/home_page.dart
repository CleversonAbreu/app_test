import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
              onPressed: () => GoRouter.of(context).go('/settings')),
        ],
      ),
      body: Center(
        child: Text(AppLocalizations.of(context)!.welcomeMessage),
      ),
    );
  }
}
