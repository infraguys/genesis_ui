import 'package:genesis/src/layer_data/requests/sign_in_req.dart';
import 'package:genesis/src/layer_data/source/local/token_dao.dart';
import 'package:genesis/src/layer_data/source/remote/i_remote_iam_client_api.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/sign_in_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required IRemoteIamClientApi iamApi,
    required TokenDao tokenDao,
  }) : _iamApi = iamApi,
       _tokenDao = tokenDao;

  final IRemoteIamClientApi _iamApi;
  final TokenDao _tokenDao;

  @override
  Future<User> signIn(SignInParams params) async {
    final req = SignInReq(params);

    final tokenDto = await _iamApi.createTokenByPassword(req);
    await _tokenDao.writeToken(tokenDto.accessToken);

    final userDto = await _iamApi.getCurrentUser(req.iamClientUuid);
    return userDto.toEntity();
  }
}
