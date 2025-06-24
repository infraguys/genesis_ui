import 'package:dio/dio.dart';

class NetworkException implements Exception {
  factory NetworkException(DioException exception) {
    final statusCode = exception.response!.statusCode!;
    final message = switch (exception.type) {
      DioExceptionType.cancel => 'Request to API server was cancelled',
      DioExceptionType.connectionTimeout => 'Connection timeout with API server',
      DioExceptionType.unknown => 'Connection to API server failed due to internet connection',
      DioExceptionType.receiveTimeout => 'Receive timeout in connection with API server',
      DioExceptionType.sendTimeout => 'Send timeout in connection with API server',
      DioExceptionType.badResponse when statusCode == 400 => 'Bad request',
      DioExceptionType.badResponse when statusCode == 404 => 'The requested resource was not found',
      DioExceptionType.badResponse when statusCode == 500 => 'Internal server error',
      _ => 'Something went wrong',
    };
    message;

    return NetworkException._(message);
  }

  NetworkException._(this.message);

  final String message;
}
