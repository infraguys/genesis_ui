import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/api_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';

base class BaseNetworkException implements Exception {
  BaseNetworkException(this.message);

  factory BaseNetworkException.from(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.badResponse => ApiException.from(exception),
      _ => NetworkException.from(exception),
    };
  }

  final String message;
}
