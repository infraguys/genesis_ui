import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/sign_in_params.dart';

abstract interface class IAuthRepository {
  Future<User> signIn(SignInParams params);

  Future<void> signOut();

  Future<User> restoreSession();
}
