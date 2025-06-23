import 'package:genesis/src/features/auth/data/dtos/iam_client_dto.dart';
import 'package:genesis/src/features/auth/data/requests/create_token_req.dart';

abstract interface class IRemoteIamClientApi {
  Future<void> createTokenByPassword(CreateTokenReq req);

  Future<void> resetPasswordIamClient(String iamClientUuid);

  Future<IamClientDto?> fetchCurrentClient(String iamClientUuid);
}
