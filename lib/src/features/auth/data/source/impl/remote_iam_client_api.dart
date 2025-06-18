import 'package:dio/dio.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/features/auth/data/dto/iam_client_dto.dart';
import 'package:genesis/src/features/auth/data/source/i_remote_iam_client_api.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';

final class RemoteIamClientApi implements IRemoteIamClientApi {
  RemoteIamClientApi(this._client);

  final RestClient _client;

  @override
  Future<IamClientDto> createTokenByPassword(CreateTokenParams req) async {
    final url = '/v1/iam/clients/${req.iamClientUuid}/actions/get_token/invoke';

    final response = await _client.post<Map<String, dynamic>>(
      url,
      data: req.toJson(),
      options: Options(
        headers: {
          Headers.contentTypeHeader: Headers.formUrlEncodedContentType,
        },
      ),
    );
    final dto = IamClientDto.fromJson(response.data!);
    return dto;
  }

  @override
  Future<void> resetPasswordIamClient() {
    // TODO: implement resetPasswordIamClient
    throw UnimplementedError();
  }
}
