part of 'result.dart';

final class _Error<T> extends Result<T> {
  const _Error._(this.error);

  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}