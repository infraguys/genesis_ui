import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/endpoints/clients_endpoints.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/iam_client/data/dtos/client_introspection_dto.dart';
import 'package:genesis/src/features/iam_client/data/dtos/token_dto.dart';
import 'package:genesis/src/features/iam_client/data/requests/get_introspection_req.dart';
import 'package:genesis/src/features/iam_client/data/requests/token_req.dart';
import 'package:genesis/src/features/users/data/dtos/user_dto.dart';

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

  Future<UserDto> getCurrentUser() async {
    try {
      final Response(:data, :requestOptions) = await _client.get<Map<String, dynamic>>(
        ClientsEndpoints.getMe().fullPath,
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
