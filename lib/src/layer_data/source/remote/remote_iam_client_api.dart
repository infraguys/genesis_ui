import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/client_introspection_dto.dart';
import 'package:genesis/src/layer_data/dtos/token_dto.dart';
import 'package:genesis/src/layer_data/dtos/user_dto.dart';
import 'package:genesis/src/layer_data/requests/iam_client_requests/get_introspection_req.dart';
import 'package:genesis/src/layer_data/requests/iam_client_requests/token_req.dart';
import 'package:genesis/src/layer_data/requests/users/get_current_user_req.dart';

final class RemoteIamClientApi {
  RemoteIamClientApi(this._client);

  final RestClient _client;

  Future<TokenDto> getToken(TokenReq req) async {
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

  Future<UserDto> getCurrentUser([GetCurrentUserReq req = const GetCurrentUserReq()]) async {
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

  Future<ClientIntrospectionDto> introspectClient(GetIntrospectionReq req) async {
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
