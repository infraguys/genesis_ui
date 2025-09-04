abstract interface class JsonEncodable {
  /// Converts the object to a JSON-serializable map.
  Map<String, dynamic> toJson();
}
