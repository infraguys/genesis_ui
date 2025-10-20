// lib/src/core/polling/polling_controller.dart
import 'dart:async';

class PollingController {
  static const Duration _period = Duration(seconds: 5);

  Timer? _timer;
  bool _isTickInProgress = false;

  bool get isActive => _timer != null;

  /// Запускает поллинг. Сразу делает первый тик, затем каждые 5 сек.
  void start(void Function() onTick) {
    stop();
    // первый тик сразу
    _run(onTick);
    _timer = Timer.periodic(_period, (_) => _run(onTick));
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _run(void Function() onTick) async {
    if (_isTickInProgress) {
      return;
    }
    // защита от наложения
    _isTickInProgress = true;
    try {
      onTick();
    } finally {
      _isTickInProgress = false;
    }
  }
}
