import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/users/domain/params/create_user_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

final class CreateUserUseCase {
  CreateUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<User> call(CreateUserParams params) async {
    return await _repository.createUser(params);
  }
}
