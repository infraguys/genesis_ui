import 'package:genesis/src/layer_domain/params/users/delete_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

class DeleteUsersUseCase {
  DeleteUsersUseCase(this._repository);

  final IUsersRepository _repository;

  Future<List<void>> call(List<String> userUuids) async {
    return await Future.wait(
      userUuids.map((uuid) => _repository.deleteUser(DeleteUserParams(uuid))),
    );
  }
}
