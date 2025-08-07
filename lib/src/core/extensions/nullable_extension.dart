extension Nullable<T> on T? {
  T? notNull(T Function(T it) cb) => this != null ? cb(this as T) : null;
}
