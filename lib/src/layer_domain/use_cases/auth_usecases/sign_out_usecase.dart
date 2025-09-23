import 'package:genesis/src/layer_domain/repositories/i_auth_repository.dart';

class SignOutUseCase {
  SignOutUseCase(this._repo);

  final IAuthRepository _repo;

  Future<void> call() async {
    return await _repo.signOut();
  }
}
