import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';

final class NetworkException extends BaseNetworkException {
  NetworkException(super.message);

  factory NetworkException.from(DioException exception) {
    final data = exception.response?.data;

    late final String? message;

    if (data case {'type': String _, 'code': int _, 'message': String msg}) {
      message = msg;
    }

    return switch (exception.type) {
      DioExceptionType.connectionError => ConnectionError(message ?? 'Connection error'),
      DioExceptionType.connectionTimeout => TimeoutError(message ?? 'Connection timeout'),
      DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout => TimeoutError(message ?? 'Timeout error'),
      DioExceptionType.cancel => RequestCancelled(message ?? 'Request was cancelled'),
      DioExceptionType.unknown => ConnectionError(message ?? 'Unknown connection error'),
      _ => NetworkException(message ?? 'Unknown network error'),
    };
  }
}

final class ConnectionError extends NetworkException {
  ConnectionError(super.message);
}

final class TimeoutError extends NetworkException {
  TimeoutError(super.message);
}

final class RequestCancelled extends NetworkException {
  RequestCancelled(super.message);
}

final class SendTimeoutError extends NetworkException {
  SendTimeoutError(super.message);
}

final class ReceiveTimeoutError extends NetworkException {
  ReceiveTimeoutError(super.message);
}
