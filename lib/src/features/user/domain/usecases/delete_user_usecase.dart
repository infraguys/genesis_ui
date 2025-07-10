import 'package:genesis/src/features/user/domain/i_user_repository.dart';

class DeleteUserUseCase {
  DeleteUserUseCase(this._repository);

  final IUserRepository _repository;

  Future<void> call(String userUuid) async {
    await _repository.deleteUser(userUuid);
  }
}
