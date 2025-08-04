import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

class GetUsersUseCase {
  GetUsersUseCase(this._usersRepo);

  final IUsersRepository _usersRepo;

  Future<List<User>> call() async {
    return await _usersRepo.getUsers();
  }
}
