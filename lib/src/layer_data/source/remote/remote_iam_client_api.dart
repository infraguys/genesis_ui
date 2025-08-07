import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/auth_user_dto.dart';
import 'package:genesis/src/layer_data/dtos/token_dto.dart';
import 'package:genesis/src/layer_data/requests/users/sign_in_req.dart';
import 'package:genesis/src/layer_data/source/remote/i_remote_iam_client_api.dart';

final class RemoteIamClientApi implements IRemoteIamClientApi {
  RemoteIamClientApi(this._client);

  final RestClient _client;

  static const _iamClientUrl = '/v1/iam/clients';

  @override
  Future<TokenDto> createTokenByPassword(SignInReq req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.toPath(_iamClientUrl),
        data: req.toJson(),
        options: Options(
          headers: {Headers.contentTypeHeader: Headers.formUrlEncodedContentType},
        ),
      );
      return TokenDto.fromJson(data!);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<AuthUserDto> getCurrentUser(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.get<Map<String, dynamic>>(
        req.toPath(_iamClientUrl),
      );
      if (data != null) {
        if (data case {
          'user': Map<String, dynamic> userJson,
          'organization': List<dynamic> orgJson,
          'project_id': _,
        }) {
          userJson.putIfAbsent('organization', () => orgJson);
          return AuthUserDto.fromJson(userJson);
        }
      }
      throw DataNotFoundException(requestOptions.uri.path);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
