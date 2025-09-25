import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/iam/permission_names.dart';
import 'package:genesis/src/layer_domain/params/sign_in_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_auth_repository.dart';

class SignInUseCase {
  SignInUseCase(this._repo);

  final IAuthRepository _repo;

  Future<({User user, PermissionNames permissionNames})> call(SignInParams params) async {
    return await _repo.signIn(params);
  }
}
