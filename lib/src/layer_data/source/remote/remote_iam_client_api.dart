import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/client_introspection_dto.dart';
import 'package:genesis/src/layer_data/dtos/token_dto.dart';
import 'package:genesis/src/layer_data/dtos/user_dto.dart';
import 'package:genesis/src/layer_data/requests/users/sign_in_req.dart';
import 'package:genesis/src/layer_data/source/remote/i_remote_iam_client_api.dart';

final class RemoteIamClientApi implements IRemoteIamClientApi {
  RemoteIamClientApi(this._client);

  final RestClient _client;

  @override
  Future<TokenDto> createTokenByPassword(SignInReq req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
        options: Options(
          headers: {
            Headers.contentTypeHeader: Headers.formUrlEncodedContentType,
          },
        ),
      );
      return TokenDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<UserDto> getCurrentUser(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );
      final userJson = data!['user'] as Map<String, dynamic>;
      return UserDto.fromJson(userJson);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<ClientIntrospectionDto> introspectClient(req) async {
    try {
      final Response(:data) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );
      return ClientIntrospectionDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
