import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/user_dto.dart';
import 'package:genesis/src/layer_data/source/remote/users_api/i_users_api.dart';

final class UsersApi implements IUsersApi {
  UsersApi(this._client);

  final RestClient _client;

  @override
  Future<List<UserDto>> getUsers(req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data == null) {
        return [];
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => UserDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<UserDto> changeUserPassword(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      if (data == null) {
        throw DataNotFoundException(requestOptions.uri.path);
      }
      return UserDto.fromJson(data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {}
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<UserDto> confirmEmail(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
      );
      if (data == null) {
        throw DataNotFoundException(requestOptions.uri.path);
      }
      return UserDto.fromJson(data);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<UserDto> forceConfirmEmail(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
      );
      if (data == null) {
        throw DataNotFoundException(requestOptions.uri.path);
      }
      return UserDto.fromJson(data);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<UserDto> createUser(req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return UserDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<void> deleteUser(req) async {
    try {
      await _client.delete<void>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<UserDto> getUser(req) async {
    try {
      final Response(:data) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );
      if (data == null) {
        throw DataNotFoundException(req.toPath());
      }
      return UserDto.fromJson(data);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<UserDto> resetUserPassword() {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }

  @override
  Future<UserDto> updateUser(req) async {
    try {
      final Response(:data) = await _client.put<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      if (data == null) {
        throw DataNotFoundException(req.toPath());
      }
      return UserDto.fromJson(data);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
