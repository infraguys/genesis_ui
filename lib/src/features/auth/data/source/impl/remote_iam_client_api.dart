import 'package:dio/dio.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/features/auth/data/dto/iam_client_dto.dart';
import 'package:genesis/src/features/auth/data/dto/token_dto.dart';
import 'package:genesis/src/features/auth/data/source/i_remote_iam_client_api.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';

final class RemoteIamClientApi implements IRemoteIamClientApi {
  RemoteIamClientApi(this._client);

  final RestClient _client;

  static const _iamClientUrl = '/v1/iam/clients';

  @override
  Future<void> createTokenByPassword(CreateTokenParams req) async {
    final url = '$_iamClientUrl/${req.iamClientUuid}/actions/get_token/invoke';

    final response = await _client.post<Map<String, dynamic>>(
      url,
      data: req.toJson(),
      options: Options(
        headers: {
          Headers.contentTypeHeader: Headers.formUrlEncodedContentType,
        },
      ),
    );
    final dto = TokenDto.fromJson(response.data!);
    _client.updateAccessToken(dto.accessToken);
  }

  @override
  Future<void> resetPasswordIamClient(String iamClientUuid) async {
    final url = '$_iamClientUrl/$iamClientUuid/actions/reset_password/invoke';

    // TODO(E.Koretsky): заменить возвращаемый тип
    await _client.post<dynamic>(url);
  }

  @override
  Future<IamClientDto?> fetchCurrentClient(String iamClientUuid) async {
    final url = '$_iamClientUrl/$iamClientUuid/actions/me';

    try {
      final response = await _client.get<Map<String, dynamic>>(url);
      if (response.data != null) {
        return IamClientDto.fromJson(response.data!);
      }
    } on Exception catch (e) {}
    return null;
  }
}
