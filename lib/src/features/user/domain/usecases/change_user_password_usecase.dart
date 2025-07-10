import 'package:genesis/src/features/user/domain/i_user_repository.dart';
import 'package:genesis/src/features/user/domain/params/change_user_password_params.dart';

class ChangeUserPasswordUseCase {
  ChangeUserPasswordUseCase(this._repository);

  final IUserRepository _repository;

  Future<void> call(ChangeUserPasswordParams params) async {
    await _repository.changeUserPassword(params);
  }
}
