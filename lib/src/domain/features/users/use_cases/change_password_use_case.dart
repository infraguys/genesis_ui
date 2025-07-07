import 'package:genesis/src/domain/entities/user.dart';
import 'package:genesis/src/domain/features/users/repository/i_users_repository.dart';

class ChangePasswordUseCase {
  ChangePasswordUseCase(this._repository);

  final IUsersRepository _repository;

  Future<User> call() async {
    return await _repository.changeUserPassword();
  }
}
