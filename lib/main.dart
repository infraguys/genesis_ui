import 'package:flutter/material.dart';
import 'package:genesis/src/di/di_container.dart';
import 'package:genesis/src/l10n/generated/app_localizations.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:genesis/src/routing/url_strategy/app_url_strategy.dart';
import 'package:genesis/src/theming/app_theme.dart';

void main() {
  configureAppUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DiContainer(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme().light,
      ),
    );
  }
}
