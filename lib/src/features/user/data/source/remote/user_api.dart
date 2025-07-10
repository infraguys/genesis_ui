import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/features/user/data/dtos/user_feat_role_dto.dart';
import 'package:genesis/src/features/user/data/dtos/user_feat_user_dto.dart';
import 'package:genesis/src/features/user/data/requests/update_user_req.dart';
import 'package:genesis/src/features/user/data/source/remote/i_user_api.dart';

final class UserApi implements IUserApi {
  UserApi(this._client);

  final RestClient _client;

  static const _usersUrl = '/v1/iam/users/';

  @override
  Future<UserFeatUserDto> changeUserPassword(req) async {
    final url = '$_usersUrl/${req.uuid}/actions/change_password/invoke';

    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        url,
        data: req.toJson(),
      );
      if (data == null) {
        throw DataNotFoundException(requestOptions.uri.path);
      }
      return UserFeatUserDto.fromJson(data);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<UserFeatUserDto> confirmEmail(String userUuid) async {
    final url = '$_usersUrl/$userUuid/actions/confirm_email/invoke';

    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(url);
      if (data == null) {
        throw DataNotFoundException(requestOptions.uri.path);
      }
      return UserFeatUserDto.fromJson(data);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<UserFeatUserDto> createUser(req) async {
    const url = _usersUrl;
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(url, data: req.toJson());
      return UserFeatUserDto.fromJson(data!);
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
  Future<UserFeatUserDto> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<UserFeatUserDto> resetUserPassword() {
    // TODO: implement resetUserPassword
    throw UnimplementedError();
  }

  @override
  Future<UserFeatUserDto> updateUser(UpdateUserReq req) async {
    final url = '$_usersUrl/${req.uuid}';
    try {
      final Response(:data) = await _client.put<Map<String, dynamic>>(
        url,
        data: req.toJson(),
      );
      if (data == null) {
        throw DataNotFoundException(url);
      }
      return UserFeatUserDto.fromJson(data);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<List<UserFeatRoleDto>> getUserRoles(String userUuid) async {
    final url = '$_usersUrl/$userUuid/actions/get_my_roles';

    try {
      final Response(:data) = await _client.get<List<dynamic>>(url);
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => UserFeatRoleDto.fromJson(it)).toList();
      }
    } on DioException catch (e) {
      throw NetworkException(e);
    }
    return [];
  }
}
