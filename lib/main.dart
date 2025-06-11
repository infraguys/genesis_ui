import 'package:flutter/material.dart';
import 'package:genesis/src/l10n/generated/app_localizations.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/theming/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme().light,
    );
  }
}
