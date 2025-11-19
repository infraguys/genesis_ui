class Ansi {
  const Ansi._(this._color);

  final String _color;
  final String _reset = '\x1B[0m';

  /// Стандартные ANSI-цвета
  static const Ansi black = Ansi._('\x1B[30m');
  static const Ansi red = Ansi._('\x1B[31m');
  static const Ansi green = Ansi._('\x1B[32m');
  static const Ansi yellow = Ansi._('\x1B[33m');
  static const Ansi blue = Ansi._('\x1B[34m');
  static const Ansi magenta = Ansi._('\x1B[35m');
  static const Ansi cyan = Ansi._('\x1B[36m');
  static const Ansi white = Ansi._('\x1B[37m');

  /// Яркие (bright) варианты
  static const Ansi brightBlack = Ansi._('\x1B[90m');
  static const Ansi brightRed = Ansi._('\x1B[91m');
  static const Ansi brightGreen = Ansi._('\x1B[92m');
  static const Ansi brightYellow = Ansi._('\x1B[93m');
  static const Ansi brightBlue = Ansi._('\x1B[94m');
  static const Ansi brightMagenta = Ansi._('\x1B[95m');
  static const Ansi brightCyan = Ansi._('\x1B[96m');
  static const Ansi brightWhite = Ansi._('\x1B[97m');

  /// Модификаторы (только стили, цвета не меняют)
  Ansi get bold => Ansi._('\x1B[1m$_color');
  Ansi get underline => Ansi._('\x1B[4m$_color');
  Ansi get italic => Ansi._('\x1B[3m$_color');
  Ansi get dim => Ansi._('\x1B[2m$_color');

  /// Применение: print(Ansi.red('hello'))
  String call(String text) => '$_color$text$_reset';

  @override
  String toString() => _color;
}
