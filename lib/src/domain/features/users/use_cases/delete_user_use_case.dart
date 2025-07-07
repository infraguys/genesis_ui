import 'package:genesis/src/domain/features/users/repository/i_users_repository.dart';

class DeleteUserUseCase {
  DeleteUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<void> call(String userUuid) async {
    await _repository.deleteUser(userUuid);
  }
}
