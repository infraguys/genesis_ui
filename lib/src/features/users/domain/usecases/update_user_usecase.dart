import 'package:genesis/src/features/users/domain/params/update_user_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class UpdateUserUseCase {
  UpdateUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<void> call(UpdateUserParams params) async {
    await _repository.updateUser(params);
  }
}
