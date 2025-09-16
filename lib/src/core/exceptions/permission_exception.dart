class PermissionException implements Exception {
  PermissionException() : message = 'Not permission';

  final String message;
}
