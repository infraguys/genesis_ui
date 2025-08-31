import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

class DeleteUserUseCase {
  DeleteUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<void> call(String uuid) async {
    await _repository.deleteUser(uuid);
  }
}

class DeleteUsersUseCase {
  DeleteUsersUseCase(this._repository);

  final IUsersRepository _repository;

  Future<List<void>> call(List<User> users) async {
    return await Future.wait(
      users.map((user) => _repository.deleteUser(user.uuid)),
    );
  }
}
