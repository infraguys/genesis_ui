import 'package:genesis/src/features/auth/data/dto/iam_client_dto.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';

abstract interface class IRemoteIamClientApi {
  Future<IamClientDto> createTokenByPassword(CreateTokenParams params);

  Future<void> resetPasswordIamClient();
}
