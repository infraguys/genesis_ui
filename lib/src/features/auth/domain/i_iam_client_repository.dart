import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';

abstract interface class IIamClientRepository {
  Future<IamClient> createTokenByPassword(CreateTokenParams params);

  Future<void> resetPasswordIamClient();
}
