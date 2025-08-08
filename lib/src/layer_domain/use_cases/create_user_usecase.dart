import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/create_user_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

final class CreateUserUseCase {
  CreateUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<User> call(CreateUserParams params) async {
    return await _repository.createUser(params);
  }
}
