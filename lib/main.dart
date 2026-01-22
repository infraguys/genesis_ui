import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/storage_clients/secure_storage_client.dart';
import 'package:genesis/src/core/storage_clients/shared_pref_storage.dart';
import 'package:genesis/src/core/utils/app_logger.dart';
import 'package:genesis/src/injection/di_scope.dart';
import 'package:genesis/src/injection/main_di_factory.dart';
import 'package:genesis/src/injection/root_di.dart';
import 'package:genesis/src/l10n/generated/app_localizations.dart';
import 'package:genesis/src/shared/presentation/ui/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      usePathUrlStrategy();

      EquatableConfig.stringify = Env.mode.isDev;
      AppLogger.configure();

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
        DiScope.provide(
          diFactory: MainDiFactory(),
          child: App(
            secureStorageClient: secureStorageClient,
            simpleStorageClient: sharedPrefStorage,
          ),
        ),
      );
    },
    (error, stack) => debugPrint('Zone error: $error\n'),
  );
}

class App extends StatefulWidget {
  const App({
    required this.secureStorageClient,
    required this.simpleStorageClient,
    super.key,
  });

  final ISimpleStorageClient simpleStorageClient;
  final ISecureStorageClient secureStorageClient;

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
    return RootDi(
      secureStorageClient: widget.secureStorageClient,
      simpleStorageClient: widget.simpleStorageClient,
      child: ValueListenableBuilder(
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
      ),
    );
  }
}
