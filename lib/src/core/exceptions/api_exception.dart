import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';

final class ApiException extends BaseNetworkException {
  ApiException(super.message);

  factory ApiException.from(DioException exception) {
    final code = exception.response?.statusCode;
    final data = exception.response?.data;

    late final String? message;

    if (data case {'type': String _, 'code': int _, 'message': String msg}) {
      message = msg;
    }

    return switch (code) {
      400 => BadRequestException(message ?? 'Bad request'),
      401 => UnauthorizedException(message ?? 'Unauthorized'),
      403 => PermissionException(message ?? 'Permission denied'),
      404 => NotFoundException(message ?? 'The requested resource was not found'),
      500 => ServerErrorException(message ?? 'Internal server error'),
      _ => UnknownApiException(message ?? 'Unknown API error'),
    };
  }
}

final class PermissionException extends ApiException {
  PermissionException(super.message);
}

final class UnknownApiException extends ApiException {
  UnknownApiException(super.message);
}

final class BadRequestException extends ApiException {
  BadRequestException(super.message);
}

final class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message);
}

final class NotFoundException extends ApiException {
  NotFoundException(super.message);
}

final class ServerErrorException extends ApiException {
  ServerErrorException(super.message);
}
