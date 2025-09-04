class DataNotFoundException implements Exception {
  DataNotFoundException(String url) : message = 'No data found in response for $url';

  final String message;

  @override
  String toString() => 'DataNotFoundException: $message';
}
