import 'package:genesis/src/layer_data/dtos/auth_user_dto.dart';
import 'package:genesis/src/layer_data/dtos/token_dto.dart';
import 'package:genesis/src/layer_data/requests/users/get_current_user_req.dart';
import 'package:genesis/src/layer_data/requests/users/sign_in_req.dart';

abstract interface class IRemoteIamClientApi {
  Future<TokenDto> createTokenByPassword(SignInReq req);

  Future<AuthUserDto> getCurrentUser(GetCurrentUserReq req);
}
