import 'package:genesis/src/features/auth/data/dtos/auth_user_dto.dart';
import 'package:genesis/src/features/auth/data/dtos/token_dto.dart';
import 'package:genesis/src/features/auth/data/requests/sign_in_req.dart';

abstract interface class IRemoteIamClientApi {
  Future<TokenDto> createTokenByPassword(SignInReq req);

  Future<AuthUserDto> getCurrentUser(String iamClientUuid);
}
