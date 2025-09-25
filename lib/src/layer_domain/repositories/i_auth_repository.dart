import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/iam/permission_names.dart';
import 'package:genesis/src/layer_domain/params/sign_in_params.dart';

abstract interface class IAuthRepository {
  Future<({User user, PermissionNames permissionNames})> signIn(SignInParams params);

  Future<void> signOut();

  Future<({User user, PermissionNames permissionNames})> restoreSession();
}
