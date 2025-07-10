import 'package:genesis/src/features/auth/domain/auth_entities/iam_client.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';

abstract interface class IAuthRepository {
  Future<IamClient?> signIn(CreateTokenParams params);
}
