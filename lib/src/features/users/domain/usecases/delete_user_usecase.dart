import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/delete_user_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class DeleteUserUseCase {
  DeleteUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<void> call(UserUUID id) async {
    await _repository.deleteUser(DeleteUserParams(id));
  }
}