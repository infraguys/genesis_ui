import 'package:genesis/src/layer_domain/params/change_user_password_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

class ChangeUserPasswordUseCase {
  ChangeUserPasswordUseCase(this._repository);

  final IUsersRepository _repository;

  Future<void> call(ChangeUserPasswordParams params) async {
    await _repository.changeUserPassword(params);
  }
}
