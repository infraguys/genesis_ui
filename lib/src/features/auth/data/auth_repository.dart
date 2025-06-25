import 'package:genesis/src/features/auth/data/requests/create_token_req.dart';
import 'package:genesis/src/features/auth/data/requests/sign_up_req.dart';
import 'package:genesis/src/features/auth/data/source/remote/i_remote_iam_client_api.dart';
import 'package:genesis/src/features/auth/data/source/remote/i_remote_me_api.dart';
import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';
import 'package:genesis/src/features/auth/domain/entity/user.dart';
import 'package:genesis/src/features/auth/domain/i_auth_repository.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';
import 'package:genesis/src/features/auth/domain/params/sign_up_params.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required IRemoteIamClientApi iamApi,
    required IRemoteMeApi meApi,
  }) : _iamApi = iamApi,
       _meApi = meApi;

  final IRemoteIamClientApi _iamApi;
  final IRemoteMeApi _meApi;

  @override
  Future<IamClient?> getCurrentClient(CreateTokenParams params) async {
    final req = CreateTokenReq.fromParams(params);
    await _iamApi.createTokenByPassword(req);

    final dto = await _iamApi.fetchCurrentClient(params.iamClientUuid);
    return dto?.toEntity();
  }

  @override
  Future<User> singUp(SignUpParams params) async {
    final req = SignUpReq.fromParams(params);
    final dto = await _meApi.signUp(req);
    return dto.toEntity();
  }
}
