import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/get_users_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class GetUsersUseCase {
  GetUsersUseCase(this._usersRepo);

  final IUsersRepository _usersRepo;

  Future<List<User>> call(GetUsersParams params) async {
    return await _usersRepo.getUsers(params);
  }
}
