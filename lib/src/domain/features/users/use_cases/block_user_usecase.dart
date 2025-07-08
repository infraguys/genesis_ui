import 'package:genesis/src/domain/features/users/repository/i_users_repository.dart';

class BlockUserUseCase {
  BlockUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<void> call() async {
    // _repository.
  }
}
