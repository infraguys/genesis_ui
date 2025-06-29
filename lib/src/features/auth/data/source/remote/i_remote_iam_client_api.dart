import 'package:genesis/src/features/auth/data/dtos/iam_client_dto.dart';
import 'package:genesis/src/features/auth/data/dtos/token_dto.dart';
import 'package:genesis/src/features/auth/data/requests/create_token_req.dart';

abstract interface class IRemoteIamClientApi {
  Future<TokenDto> createTokenByPassword(CreateTokenReq req);

  Future<IamClientDto?> getCurrentIamClient(String iamClientUuid);
}
