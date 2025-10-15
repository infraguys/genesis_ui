import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class BlockUserUseCase {
  BlockUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<void> call() async {
    throw UnimplementedError();
  }
}
