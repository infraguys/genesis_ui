import 'package:genesis/src/layer_domain/params/users/update_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

class UpdateUserUseCase {
  UpdateUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<void> call(UpdateUserParams params) async {
    await _repository.updateUser(params);
  }
}
