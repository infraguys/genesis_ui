import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/features/auth/data/dtos/user_dto.dart';
import 'package:genesis/src/features/auth/data/requests/sign_up_req.dart';
import 'package:genesis/src/features/auth/data/source/remote/i_remote_me_api.dart';

final class RemoteMeApi implements IRemoteMeApi {
  RemoteMeApi(this._client);

  final RestClient _client;

  static const _usersUrl = '/v1/iam/users/';

  @override
  Future<UserDto> signUp(SignUpReq req) async {
    const url = _usersUrl;
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(url, data: req.toJson());
      return UserDto.fromJson(data!);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
