import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/features/auth/data/dtos/user_dto.dart';
import 'package:genesis/src/features/auth/data/requests/sign_up_req.dart';
import 'package:genesis/src/features/auth/data/source/i_remote_user_api.dart';

final class RemoteUserApi implements IRemoteUserApi {
  RemoteUserApi(this._client);

  final RestClient _client;

  static const _usersUrl = '/v1/iam/users';

  @override
  Future<UserDto> signUp(SignUpReq req) async {
    const url = _usersUrl;
    final response = await _client.post<Map<String, dynamic>>(url, data: req.toJson());
    return UserDto.fromJson(response.data!);
  }

  @override
  Future<UserDto> changeUserPassword() {
    // TODO: implement changeUserPassword
    throw UnimplementedError();
  }

  @override
  Future<UserDto> confirmUserEmail() {
    // TODO: implement confirmUserEmail
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
  Future<List<UserDto>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
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
