import 'package:genesis/src/features/auth/data/source/access_token_dao.dart';
import 'package:genesis/src/features/auth/data/source/i_remote_iam_client_api.dart';
import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';
import 'package:genesis/src/features/auth/domain/i_iam_client_repository.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';

class IamClientRepository implements IIamClientRepository {
  IamClientRepository({
    required this.iamApi,
    required this.accessTokenDao,
  });

  final IRemoteIamClientApi iamApi;
  final IAccessTokenDao accessTokenDao;

  @override
  Future<IamClient?> createTokenByPassword(CreateTokenParams params) async {
    final dto = await iamApi.createTokenByPassword(params);
    await accessTokenDao.writeToken(dto.accessToken);
    return dto.toEntity();
  }

  @override
  Future<void> resetPasswordIamClient() {
    // TODO: implement resetPasswordIamClient
    throw UnimplementedError();
  }
}
