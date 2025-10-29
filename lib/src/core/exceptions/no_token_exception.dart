class NoTokenException implements Exception {
  NoTokenException() : message = 'Authorization token is null';

  final String message;
}
