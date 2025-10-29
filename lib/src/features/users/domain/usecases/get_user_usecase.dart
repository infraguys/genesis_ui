import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/get_user_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class GetUserUseCase {
  GetUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<User> call(UserUUID id) async {
    return await _repository.getUser(GetUserParams(id));
  }
}
