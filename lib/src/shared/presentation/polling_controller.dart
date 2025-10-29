import 'dart:async';

class PollingController {
  static const Duration _period = Duration(seconds: 5);

  Timer? _timer;

  bool get isActive => _timer != null;

  /// Запускает поллинг. Сразу делает первый тик, затем каждые 5 сек.
  void start(void Function() onTick) {
    stop();
    // первый тик сразу
    onTick();
    _timer = Timer.periodic(_period, (_) => onTick());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }
}
