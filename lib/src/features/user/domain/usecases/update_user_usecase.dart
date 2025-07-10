import 'package:genesis/src/features/user/domain/i_user_repository.dart';
import 'package:genesis/src/features/user/domain/params/update_user_params.dart';

class UpdateUserUseCase {
  UpdateUserUseCase(this._repository);

  final IUserRepository _repository;

  Future<void> call(UpdateUserParams params) async {
    await _repository.updateUser(params);
  }
}
