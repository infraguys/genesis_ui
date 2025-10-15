import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/confirm_email_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

final class ConfirmEmailUseCase {
  ConfirmEmailUseCase(this._repository);

  final IUsersRepository _repository;

  Future<User> call(UserUUID id) async {
    return await _repository.confirmEmail(ConfirmEmailParams(id));
  }
}