import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/features/users/data/dtos/user_dto.dart';
import 'package:genesis/src/features/users/data/source/remote/i_users_api.dart';

final class UsersApi implements IUsersApi {
  UsersApi(this._client);

  final RestClient _client;

  static const _usersUrl = '/v1/iam/users/';

  @override
  Future<UserDto> changeUserPassword() {
    // TODO: implement changeUserPassword
    throw UnimplementedError();
  }

  @override
  Future<UserDto> confirmEmail() {
    // TODO: implement confirmEmail
    throw UnimplementedError();
  }

  @override
  Future<UserDto> createUser() {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<UserDto> deleteUser() {
    // TODO: implement deleteUser
    throw UnimplementedError();
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
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data!);
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
}
