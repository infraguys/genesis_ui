import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/features/auth/data/dtos/auth_user_dto.dart';
import 'package:genesis/src/features/auth/data/dtos/token_dto.dart';
import 'package:genesis/src/features/auth/data/requests/create_token_req.dart';
import 'package:genesis/src/features/auth/data/sources/remote/i_remote_iam_client_api.dart';

final class RemoteIamClientApi implements IRemoteIamClientApi {
  RemoteIamClientApi(this._client);

  final RestClient _client;

  static const _iamClientUrl = '/v1/iam/clients';

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
  Future<AuthUserDto> getCurrentUser(
    String iamClientUuid,
  ) async {
    final url = '$_iamClientUrl/$iamClientUuid/actions/me';

    try {
      final Response(:data, :requestOptions) = await _client.get<Map<String, dynamic>>(url);
      if (data != null) {
        if (data case {
          'user': Map<String, dynamic> userJson,
          'organization': List<Map<String, dynamic>>? orgJson,
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
