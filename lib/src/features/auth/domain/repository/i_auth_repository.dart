import 'package:genesis/src/features/auth/domain/params/sign_in_params.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';

abstract interface class IAuthRepository {
  Future<User> signIn(SignInParams params);
}
