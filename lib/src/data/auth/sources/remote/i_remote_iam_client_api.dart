import 'package:genesis/src/data/auth/dtos/iam_client_dto.dart';
import 'package:genesis/src/data/auth/dtos/token_dto.dart';
import 'package:genesis/src/data/auth/requests/create_token_req.dart';

abstract interface class IRemoteIamClientApi {
  Future<TokenDto> createTokenByPassword(CreateTokenReq req);

  Future<IamClientDto?> getCurrentIamClient(String iamClientUuid);
}
