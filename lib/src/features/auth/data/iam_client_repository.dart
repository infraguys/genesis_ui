import 'package:genesis/src/features/auth/data/requests/create_token_req.dart';
import 'package:genesis/src/features/auth/data/source/i_remote_iam_client_api.dart';
import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';
import 'package:genesis/src/features/auth/domain/i_iam_client_repository.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';

class IamClientRepository implements IIamClientRepository {
  IamClientRepository(this._iamApi);

  final IRemoteIamClientApi _iamApi;

  @override
  Future<IamClient?> getCurrentClient(CreateTokenParams params) async {
    final req = CreateTokenReq.fromParams(params);
    await _iamApi.createTokenByPassword(req);

    final dto = await _iamApi.fetchCurrentClient(params.iamClientUuid);
    if (dto == null) {
      return null;
    }
    return dto.toEntity();
  }

  @override
  Future<void> resetPasswordIamClient() {
    // TODO: implement resetPasswordIamClient
    throw UnimplementedError();
  }
}
