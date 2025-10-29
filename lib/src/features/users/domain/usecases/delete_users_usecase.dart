import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/delete_user_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class DeleteUsersUseCase {
  DeleteUsersUseCase(this._repository);

  final IUsersRepository _repository;

  Future<void> call(List<User> users) async {
    await Future.wait(
      users.map((user) => _repository.deleteUser(DeleteUserParams(user.uuid))),
    );
  }
}
