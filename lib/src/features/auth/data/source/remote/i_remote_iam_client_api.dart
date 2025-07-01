import 'package:genesis/src/features/auth/data/dtos/auth_user_dto.dart';
import 'package:genesis/src/features/auth/data/dtos/iam_client_dto.dart';
import 'package:genesis/src/features/auth/data/dtos/token_dto.dart';
import 'package:genesis/src/features/auth/data/requests/create_token_req.dart';
import 'package:genesis/src/features/auth/data/requests/sign_up_req.dart';

abstract interface class IRemoteIamClientApi {
  Future<TokenDto> createTokenByPassword(CreateTokenReq req);

  Future<IamClientDto?> getCurrentIamClient(String iamClientUuid);

  Future<AuthUserDto> signUp(SignUpReq req);
}
