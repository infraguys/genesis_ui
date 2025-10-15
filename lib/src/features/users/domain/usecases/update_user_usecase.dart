import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/update_user_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class UpdateUserUseCase {
  UpdateUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<User> call(UpdateUserParams params) async {
    return await _repository.updateUser(params);
  }
}
