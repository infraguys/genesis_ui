import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';

abstract interface class IIamClientRepository {
  Future<IamClient> createTokenByPassword();

  Future<void> resetPasswordIamClient();
}
