import 'package:genesis/src/features/iam_client/domain/repositories/i_auth_repository.dart';

class SignOutUseCase {
  SignOutUseCase(this._repo);

  final IAuthRepository _repo;

  Future<void> call() async {
    return await _repo.signOut();
  }
}
