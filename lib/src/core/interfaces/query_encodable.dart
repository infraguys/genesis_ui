abstract interface class QueryEncodable {
  /// Converts the object to a map that can be used in a query string.
  Map<String, String> toQuery();
}
