import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/storage_clients/secure_storage_client.dart';
import 'package:genesis/src/core/storage_clients/shared_pref_storage.dart';
import 'package:genesis/src/core/utils/ansi.dart';
import 'package:genesis/src/injection/root_di.dart';
import 'package:genesis/src/l10n/generated/app_localizations.dart';
import 'package:genesis/src/shared/presentation/ui/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      usePathUrlStrategy();

      EquatableConfig.stringify = Env.mode.isDev;

      Logger.root.level = Level.CONFIG;
      Logger.root.onRecord.listen((record) {
        final ansi = switch (record.level) {
          .SEVERE || .SHOUT => Ansi.brightRed,
          .WARNING => Ansi.yellow,
          .INFO => Ansi.cyan,
          .CONFIG => Ansi.white,
          .FINE || .FINER || .FINEST => Ansi.green,
          _ => Ansi.white,
        };

        final msg = '[${record.level.name}][${record.loggerName}][${record.time}]: ${record.message}';

        debugPrint(ansi(msg));
      });

      final sharedPrefStorage = await SharedPrefStorage.init();
      final secureStorageClient = FlutterSecureStorageClient.init();

      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        debugPrint('Flutter error: ${details.exception}\n');
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        debugPrint('Platform error: $error\n');
        return true;
      };

      runApp(
        RootDi(
          secureStorageClient: secureStorageClient,
          simpleStorageClient: sharedPrefStorage,
          child: const App(),
        ),
      );
    },
    (error, stack) {
      debugPrint('Zone error: $error\n');
    },
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
    setState(() => key = UniqueKey());
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: key, child: widget.child);
  }
}
