import 'package:genesis/src/features/auth/data/source/i_remote_iam_client_api.dart';
import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';
import 'package:genesis/src/features/auth/domain/i_iam_client_repository.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';

class IamClientRepository implements IIamClientRepository {
  IamClientRepository({
    required this.iamApi,
  });

  final IRemoteIamClientApi iamApi;

  @override
  Future<IamClient?> fetchCurrentClient(CreateTokenParams params) async {
    await iamApi.createTokenByPassword(params);
    final dto = await iamApi.fetchCurrentClient();
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
