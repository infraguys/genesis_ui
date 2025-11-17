import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/storage_clients/secure_storage_client.dart';
import 'package:genesis/src/core/storage_clients/shared_pref_storage.dart';
import 'package:genesis/src/injection/di_container.dart';
import 'package:genesis/src/l10n/generated/app_localizations.dart';
import 'package:genesis/src/routing/url_strategy/app_url_strategy.dart';
import 'package:genesis/src/shared/presentation/ui/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureAppUrlStrategy();
  EquatableConfig.stringify = Env.mode.isDev;

  final sharedPrefStorage = await SharedPrefStorage.init();
  final secureStorageClient = FlutterSecureStorageClient.init();



  runApp(
    DiContainer(
      simpleStorageClient: sharedPrefStorage,
      secureStorageClient: secureStorageClient,
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  static void restartApplication(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()?._restart();
  }

  @override
  State<App> createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  final keyNotifier = ValueNotifier(UniqueKey());

  void _restart() => keyNotifier.value = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: keyNotifier,
      builder: (context, value, child) {
        return KeyedSubtree(
          key: keyNotifier.value,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: context.read<GoRouter>(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme().light,
            darkTheme: AppTheme().dark,
            themeMode: ThemeMode.dark, // Change to ThemeMode.dark for dark mode
          ),
        );
      },
    );
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({required this.child, super.key});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
