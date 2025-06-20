import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  var _token = '';

  set token(String accessToken) => _token = accessToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $_token';
    handler.next(options);
  }
}
