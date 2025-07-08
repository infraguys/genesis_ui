import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/data/users/dtos/user_dto.dart';
import 'package:genesis/src/data/users/dtos/users_role_dto.dart';
import 'package:genesis/src/data/users/source/remote/i_users_api.dart';
import 'package:genesis/src/data/users/source/requests/create_user_req.dart';

final class UsersApi implements IUsersApi {
  UsersApi(this._client);

  final RestClient _client;

  static const _usersUrl = '/v1/iam/users/';

  @override
  Future<UserDto> changeUserPassword(String userUuid) async {
    final url = '$_usersUrl/$userUuid/actions/change_password/invoke';

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
  Future<UserDto> confirmEmail(String userUuid) async {
    final url = '$_usersUrl/$userUuid/actions/confirm_email/invoke';

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
  Future<UserDto> createUser(CreateUserReq req) async {
    const url = _usersUrl;
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(url, data: req.toJson());
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
  Future<List<UserDto>> getUsers() async {
    const url = _usersUrl;

    try {
      final Response(:data) = await _client.get<List<dynamic>>(url);
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => UserDto.fromJson(it)).toList();
      }
    } on DioException catch (e) {
      throw NetworkException(e);
    }
    return [];
  }

  @override
  Future<UserDto> resetUserPassword() {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }

  @override
  Future<UserDto> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<List<UsersRoleDto>> getUserRoles(String userUuid) async {
    final url = '$_usersUrl/$userUuid/actions/get_my_roles';

    try {
      final Response(:data) = await _client.get<List<dynamic>>(url);
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => UsersRoleDto.fromJson(it)).toList();
      }
    } on DioException catch (e) {
      throw NetworkException(e);
    }
    return [];
  }
}
