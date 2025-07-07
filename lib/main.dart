import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/injection/di_container.dart';
import 'package:genesis/src/l10n/generated/app_localizations.dart';
import 'package:genesis/src/presentation/routing/url_strategy/app_url_strategy.dart';
import 'package:genesis/src/presentation/theming/app_theme.dart';
import 'package:go_router/go_router.dart';

void main() async {
  configureAppUrlStrategy();
  runApp(const App());
  WidgetsFlutterBinding.ensureInitialized();
  EquatableConfig.stringify = Env.mode.isDev;
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return DiContainer(
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: context.read<GoRouter>(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme().light,
          );
        },
      ),
    );
  }
}
