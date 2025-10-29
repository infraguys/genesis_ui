import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/force_confirm_email_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

final class ForceConfirmEmailUseCase {
  ForceConfirmEmailUseCase(this._repository);

  final IUsersRepository _repository;

  Future<User> call(UserID id) async {
    return await _repository.forceConfirmEmail(ForceConfirmEmailParams(id));
  }
}
