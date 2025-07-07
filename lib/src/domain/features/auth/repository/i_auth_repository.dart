import 'package:genesis/src/domain/features/auth/auth_entities/iam_client.dart';
import 'package:genesis/src/domain/features/auth/params/create_token_params.dart';

abstract interface class IAuthRepository {
  Future<IamClient?> signIn(CreateTokenParams params);
}
