import 'package:genesis/src/features/auth/domain/entity/user.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class GetUsersUseCase {
  GetUsersUseCase(this._usersRepo);

  final IUsersRepository _usersRepo;

  Future<List<User>> call() async {
    return await _usersRepo.getUsers();
  }
}
