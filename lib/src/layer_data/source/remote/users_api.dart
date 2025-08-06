import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/user_dto.dart';
import 'package:genesis/src/layer_data/dtos/user_role_dto.dart';
import 'package:genesis/src/layer_data/requests/update_user_req.dart';
import 'package:genesis/src/layer_data/source/remote/i_users_api.dart';

final class UsersApi implements IUsersApi {
  UsersApi(this._client);

  final RestClient _client;

  static const _usersUrl = '/v1/iam/users/';

  @override
  Future<List<UserDto>> getUsers() async {
    const url = _usersUrl;

    try {
      final Response(:data) = await _client.get<List<dynamic>>(url);
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => UserDto.fromJson(it)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<UserDto> changeUserPassword(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        req.toPath(_usersUrl),
        data: req.toJson(),
      );
      if (data == null) {
        throw DataNotFoundException(requestOptions.uri.path);
      }
      return UserDto.fromJson(data);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<UserDto> confirmEmail(String userUuid) async {
    final url = '$_usersUrl/$userUuid/actions/confirm_email/invoke';
    final Uri uri = Uri(pathSegments: []);

    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(url);
      if (data == null) {
        throw DataNotFoundException(requestOptions.uri.path);
      }
      return UserDto.fromJson(data);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<UserDto> createUser(req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.toPath(_usersUrl),
        data: req.toJson(),
      );
      return UserDto.fromJson(data!);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<void> deleteUser(String userUuid) async {
    final url = '$_usersUrl/$userUuid';

    try {
      await _client.delete<void>(url);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<UserDto> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<UserDto> resetUserPassword() {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }

  @override
  Future<UserDto> updateUser(UpdateUserReq req) async {
    final url = '$_usersUrl/${req.uuid}';
    try {
      final Response(:data) = await _client.put<Map<String, dynamic>>(
        url,
        data: req.toJson(),
      );
      if (data == null) {
        throw DataNotFoundException(url);
      }
      return UserDto.fromJson(data);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<List<UserRoleDto>> getUserRoles(String userUuid) async {
    final url = '$_usersUrl/$userUuid/actions/get_my_roles';

    try {
      final Response(:data) = await _client.get<List<dynamic>>(url);
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => UserRoleDto.fromJson(it)).toList();
      }
    } on DioException catch (e) {
      throw NetworkException(e);
    }
    return [];
  }
}
