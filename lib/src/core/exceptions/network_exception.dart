import 'package:dio/dio.dart';

class NetworkException implements Exception {
  factory NetworkException(DioException exception) {
    final statusCode = exception.response?.statusCode!;
    final data = exception.response?.data;

    late final String? message;
    if (data case {'type': String _, 'code': int _, 'message': String msg}) {
      message = msg;
    } else {
      message = null;
    }

    final errorMessage = switch (exception.type) {
      DioExceptionType.connectionError => message ?? 'Connection error',
      DioExceptionType.cancel => message ?? 'Request to API server was cancelled',
      DioExceptionType.connectionTimeout => message ?? 'Connection timeout with API server',
      DioExceptionType.unknown => message ?? 'Connection to API server failed due to internet connection',
      DioExceptionType.receiveTimeout => message ?? 'Receive timeout in connection with API server',
      DioExceptionType.sendTimeout => message ?? 'Send timeout in connection with API server',
      DioExceptionType.badResponse when statusCode == 400 => message ?? 'Bad request',
      DioExceptionType.badResponse when statusCode == 404 => message ?? 'The requested resource was not found',
      DioExceptionType.badResponse when statusCode == 500 => message ?? 'Internal server error',
      _ => 'Something went wrong',
    };

    return NetworkException._(errorMessage);
  }

  NetworkException._(this.message);

  final String message;
}
