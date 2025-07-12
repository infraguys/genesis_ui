import 'package:genesis/src/features/auth/data/requests/create_token_req.dart';
import 'package:genesis/src/features/auth/data/sources/local/token_dao.dart';
import 'package:genesis/src/features/auth/data/sources/remote/i_remote_iam_client_api.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';
import 'package:genesis/src/features/auth/domain/repository/i_auth_repository.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required IRemoteIamClientApi iamApi,
    required TokenDao tokenDao,
  }) : _iamApi = iamApi,
       _tokenDao = tokenDao;

  final IRemoteIamClientApi _iamApi;
  final TokenDao _tokenDao;

  @override
  Future<User> signIn(CreateTokenParams params) async {
    final req = CreateTokenReq(params);

    final tokenDto = await _iamApi.createTokenByPassword(req);
    await _tokenDao.writeToken(tokenDto.accessToken);

    final userDto = await _iamApi.getCurrentUser(req.iamClientUuid);
    return userDto.toEntity();
  }
}
