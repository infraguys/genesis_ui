import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:genesis/src/core/utils/ansi.dart';
import 'package:logging/logging.dart';

final class AppLogger {
  static StreamSubscription<LogRecord>? _sub;

  static void configure({Level level = Level.CONFIG}) {
    _sub?.cancel();

    Logger.root.level = level;

    _sub = Logger.root.onRecord.listen((record) {
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
  }

  static Future<void> dispose() async {
    await _sub?.cancel();
    _sub = null;
  }
}