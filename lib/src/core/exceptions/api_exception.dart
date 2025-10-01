import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';

base class ApiException implements BaseNetworkException {
  ApiException._(this.message);

  factory ApiException.from(DioException exception) {
    final message = switch (exception.response?.data) {
      {'message': String msg} => msg,
      _ => null,
    };

    return switch (exception.response?.statusCode) {
      400 => BadRequestException(message ?? 'Bad request'),
      401 => UnauthorizedException(message ?? 'Unauthorized'),
      403 => PermissionException(message ?? 'Permission denied'),
      404 => NotFoundException(message ?? 'The requested resource was not found'),
      500 => ServerErrorException(message ?? 'Internal server error'),
      _ => UnknownApiException(message ?? 'Unknown API error'),
    };
  }

  final String message;
}

final class BadRequestException extends ApiException {
  BadRequestException(super.message) : super._();
}

final class UnauthorizedException extends ApiException {
  UnauthorizedException(super.message) : super._();
}

final class PermissionException extends ApiException {
  PermissionException(String raw) : super._(_extractPermissionName(raw));

  static String _extractPermissionName(String raw) {
    final regex = RegExp(r'Policy rule (\S+) is disallowed');
    final match = regex.firstMatch(raw);
    if (match != null) {
      return '• ${match.group(1)!}';
    }

    final regExpBackticks = RegExp(r'`([A-Za-z][A-Za-z0-9_-]*(?:\.[A-Za-z0-9_-]+)+)`');
    final matchesInBackticks = regExpBackticks.allMatches(raw).map((m) => m.group(1)!).toSet();
    if (matchesInBackticks.isNotEmpty) {
      return matchesInBackticks.map((p) => '• $p').join('\n');
    }

    return raw;
  }
}

final class NotFoundException extends ApiException {
  NotFoundException(super.message) : super._();
}

final class ServerErrorException extends ApiException {
  ServerErrorException(super.message) : super._();
}

final class UnknownApiException extends ApiException {
  UnknownApiException(super.message) : super._();
}
