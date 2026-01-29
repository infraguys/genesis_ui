part of 'result.dart';

final class _Ok<T> extends Result<T> {
  const _Ok._(this.value);

  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}