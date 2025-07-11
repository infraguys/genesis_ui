import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

class DeleteUserUseCase {
  DeleteUserUseCase(this._repository);

  final IUsersRepository _repository;

  Future<void> call(String userUuid) async {
    await _repository.deleteUser(userUuid);
  }
}
