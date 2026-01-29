part 'ok.dart';
part 'error.dart';

sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = _Ok._;

  const factory Result.error(Exception error) = _Error._;

  R when<R>({
    required R Function(T value) ok,
    required R Function(Exception error) error,
  }) {
    return switch (this) {
      _Ok(value: final v) => ok(v),
      _Error(error: final e) => error(e)
    };
  }

  Result<R> map<R>(R Function(T value) transform) {
    return when(
      ok: (v) => Result.ok(transform(v)),
      error: (e) => Result.error(e),
    );
  }

  void match({
    required void Function(T value) ok,
    required void Function(Exception error) error,
  }) {
    when(ok: ok, error: error);
  }

  void maybeMatch({
    void Function(T value)? ok,
    void Function(Exception error)? error,
    void Function()? orElse,
  }) {
    switch (this) {
      case _Ok(value: final v):
        if (ok != null) {
          ok(v);
        } else if (orElse != null) {
          orElse();
        }
      case _Error(error: final e):
        if (error != null) {
          error(e);
        } else if (orElse != null) {
          orElse();
        }
    }
  }
}