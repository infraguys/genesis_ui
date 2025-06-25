import 'dart:async';

import 'package:dio/dio.dart';
import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/rest_client/token_interceptor.dart';

/// [RestClient] is Singleton
class RestClient {
  RestClient() : _dio = _createDio();

  late final Dio _dio;

  void updateAccessToken(String token) {
    final interceptor = _dio.interceptors.whereType<TokenInterceptor>();
    interceptor.single.token = token;
  }

  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await _dio.get<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      options: options,
      cancelToken: cancelToken,
      queryParameters: queryParameters,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }

  static Dio _createDio() {
    final dio = Dio()
      ..options = BaseOptions(
        baseUrl: Env.apiUrl,
        connectTimeout: const Duration(seconds: 15),
        contentType: Headers.jsonContentType,
      )
      ..interceptors.addAll([
        LogInterceptor(request: false, requestHeader: false, responseHeader: false),
        TokenInterceptor(),
      ]);

    return dio;
  }
}
