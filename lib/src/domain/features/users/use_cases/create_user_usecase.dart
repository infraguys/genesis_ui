import 'package:genesis/src/domain/entities/user.dart';
import 'package:genesis/src/domain/features/users/params/create_user_params.dart';
import 'package:genesis/src/domain/features/users/repository/i_users_repository.dart';

final class CreateUserUseCase {
  CreateUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<User> call(CreateUserParams params) async {
    return await _repository.createUser(params);
  }
}
