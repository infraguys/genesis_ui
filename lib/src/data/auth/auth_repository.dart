import 'package:genesis/src/data/auth/requests/create_token_req.dart';
import 'package:genesis/src/data/auth/sources/local/token_dao.dart';
import 'package:genesis/src/data/auth/sources/remote/i_remote_iam_client_api.dart';
import 'package:genesis/src/domain/features/auth/auth_entities/iam_client.dart';
import 'package:genesis/src/domain/features/auth/params/create_token_params.dart';
import 'package:genesis/src/domain/features/auth/repository/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required IRemoteIamClientApi iamApi,
    required TokenDao tokenDao,
  }) : _iamApi = iamApi,
       _tokenDao = tokenDao;

  final IRemoteIamClientApi _iamApi;
  final TokenDao _tokenDao;

  @override
  Future<IamClient?> signIn(CreateTokenParams params) async {
    final req = CreateTokenReq.fromParams(params);

    final tokenDto = await _iamApi.createTokenByPassword(req);
    await _tokenDao.writeToken(tokenDto.accessToken);

    final dto = await _iamApi.getCurrentIamClient(req.iamClientUuid);
    return dto?.toEntity();
  }
}
