import 'dart:async';

import 'package:dio/dio.dart';

/// [RestClient] is Singleton
class RestClient {
  factory RestClient() => _instance ??= RestClient._();

  RestClient._() {
    _dio = RestClient._createDio();
  }

  static RestClient? _instance;

  late final Dio _dio;

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
        baseUrl: 'http://10.130.4.45:11010',
        connectTimeout: const Duration(seconds: 15),
        contentType: Headers.jsonContentType,
      )
      ..interceptors.add(
        LogInterceptor(request: false, requestHeader: false, responseHeader: false),
      );

    return dio;
  }
}
