import 'package:genesis/src/domain/features/users/params/change_user_password_params.dart';
import 'package:genesis/src/domain/features/users/repository/i_users_repository.dart';

class ChangeUserPasswordUseCase {
  ChangeUserPasswordUseCase(this._repository);

  final IUsersRepository _repository;

  Future<void> call(ChangeUserPasswordParams params) async {
    await _repository.changeUserPassword(params);
  }
}
