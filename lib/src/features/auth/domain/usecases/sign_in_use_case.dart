import 'package:genesis/src/features/auth/domain/params/create_token_params.dart';
import 'package:genesis/src/features/auth/domain/repository/i_auth_repository.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';

class SignInUseCase {
  SignInUseCase(this._repo);

  final IAuthRepository _repo;

  Future<User> call(CreateTokenParams params) async {
    return await _repo.signIn(params);
  }
}
