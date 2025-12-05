import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/delete_user_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class DeleteUsersUseCase {
  DeleteUsersUseCase(this._repository);

  final IUsersRepository _repository;

  Future<({List<User> updated, List<User> deleted})> call({
    required List<UserID> ids,
    required List<User> currentUsers,
  }) async {

    // 1. Делаем запрос на удаление по id
    await Future.wait(
      ids.map((id) => _repository.deleteUser(DeleteUserParams(id))),
    );

    // 2. Локально фильтруем список и возвращаем новый
    final idSet = ids.toSet();

    final updatedUsers = <User>[];
    final deletedUsers = <User>[];

    for (final user in currentUsers) {
      if (idSet.contains(user.uuid)) {
        deletedUsers.add(user);
      } else {
        updatedUsers.add(user);
      }
    }
    return (updated: updatedUsers, deleted: deletedUsers);
  }
}
