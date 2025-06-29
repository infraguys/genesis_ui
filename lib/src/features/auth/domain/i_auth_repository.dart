import 'package:genesis/src/features/auth/domain/entity/iam_client.dart';
import 'package:genesis/src/features/auth/domain/entity/user.dart';
import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';
import 'package:genesis/src/features/auth/domain/params/sign_up_params.dart';

abstract interface class IAuthRepository {
  Future<User> singUp(SignUpParams params);

  Future<IamClient?> signIn(CreateTokenParams params);
}
