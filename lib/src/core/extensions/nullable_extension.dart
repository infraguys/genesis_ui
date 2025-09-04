extension Nullable<T> on T? {
  String? notNull(String Function(T it) cb) => this != null ? cb(this as T) : null;
}
