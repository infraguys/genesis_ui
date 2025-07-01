import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/features/auth/data/dtos/auth_user_dto.dart';
import 'package:genesis/src/features/auth/data/dtos/iam_client_dto.dart';
import 'package:genesis/src/features/auth/data/dtos/token_dto.dart';
import 'package:genesis/src/features/auth/data/requests/create_token_req.dart';
import 'package:genesis/src/features/auth/data/requests/sign_up_req.dart';
import 'package:genesis/src/features/auth/data/source/remote/i_remote_iam_client_api.dart';

final class RemoteIamClientApi implements IRemoteIamClientApi {
  RemoteIamClientApi(this._client);

  final RestClient _client;

  static const _iamClientUrl = '/v1/iam/clients';
  static const _usersUrl = '/v1/iam/users/';

  @override
  Future<TokenDto> createTokenByPassword(CreateTokenReq req) async {
    final url = '$_iamClientUrl/${req.iamClientUuid}/actions/get_token/invoke';

    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        url,
        data: req.toJson(),
        options: Options(
          headers: {
            Headers.contentTypeHeader: Headers.formUrlEncodedContentType,
          },
        ),
      );
      return TokenDto.fromJson(data!);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<IamClientDto?> getCurrentIamClient(String iamClientUuid) async {
    final url = '$_iamClientUrl/$iamClientUuid/actions/me';

    try {
      final Response(:data) = await _client.get<Map<String, dynamic>>(url);
      if (data != null) {
        return IamClientDto.fromJson(data);
      }
    } on DioException catch (e) {
      throw NetworkException(e);
    }
    return null;
  }

  @override
  Future<AuthUserDto> signUp(SignUpReq req) async {
    const url = _usersUrl;
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(url, data: req.toJson());
      return AuthUserDto.fromJson(data!);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
