import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';

base class NetworkException implements BaseNetworkException {
  NetworkException._(this.message);

  factory NetworkException.from(DioException exception) {
    final message = switch (exception.response?.data) {
      {'message': String msg} => msg,
      _ => null,
    };

    return switch (exception.type) {
      DioExceptionType.connectionError => ConnectionException(message ?? 'Connection error'),
      DioExceptionType.connectionTimeout => TimeoutException(message ?? 'Connection timeout'),
      DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout => TimeoutException(message ?? 'Timeout error'),
      DioExceptionType.cancel => RequestCancelledException(message ?? 'Request was cancelled'),
      _ => NetworkException._(message ?? 'Unknown network error'),
    };
  }

  final String message;
}

final class ConnectionException extends NetworkException {
  ConnectionException(super.message) : super._();
}

final class TimeoutException extends NetworkException {
  TimeoutException(super.message) : super._();
}

final class RequestCancelledException extends NetworkException {
  RequestCancelledException(super.message) : super._();
}

final class UnknownNetworkException extends NetworkException {
  UnknownNetworkException(super.message) : super._();
}
