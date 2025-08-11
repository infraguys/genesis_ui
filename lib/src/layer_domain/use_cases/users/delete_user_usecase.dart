import 'package:genesis/src/layer_domain/params/users/delete_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

class DeleteUserUseCase {
  DeleteUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<void> call(DeleteUserParams params) async {
    await _repository.deleteUser(params);
  }
}
