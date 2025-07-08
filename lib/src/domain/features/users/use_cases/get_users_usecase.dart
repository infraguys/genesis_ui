import 'package:genesis/src/domain/entities/user.dart';
import 'package:genesis/src/domain/features/users/repository/i_users_repository.dart';

class GetUsersUseCase {
  GetUsersUseCase(this._usersRepo);

  final IUsersRepository _usersRepo;

  Future<List<User>> call() async {
    return await _usersRepo.getUsers();
  }
}
