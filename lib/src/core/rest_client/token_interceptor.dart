import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  TokenInterceptor(this.token);

  final String token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }
}
