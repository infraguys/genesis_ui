import 'dart:async';

import 'package:dio/dio.dart';
import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';

/// [RestClient] is Singleton
class RestClient {
  RestClient(SecureStorageClient secureStorage) : _dio = _createDio(secureStorage);

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

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
  }) async {
    return await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }

  static Dio _createDio(SecureStorageClient secureStorage) {
    final dio = Dio()
      ..options = BaseOptions(
        baseUrl: Env.apiUrl,
        connectTimeout: const Duration(seconds: 15),
        contentType: Headers.jsonContentType,
      )
      ..interceptors.addAll(
        [
          LogInterceptor(request: false, requestHeader: false, responseHeader: false),
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final token = await secureStorage.read('access_token');
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
              return handler.next(options);
            },
          ),
        ],
      );

    return dio;
  }
}
