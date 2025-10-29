import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/confirm_email_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

final class ConfirmEmailsUseCase {
  ConfirmEmailsUseCase(this._repository);

  final IUsersRepository _repository;

  Future<List<User>> call(List<UserUUID> ids) async {
    return await Future.wait(
      ids.map((id) => _repository.confirmEmail(ConfirmEmailParams(id))),
    );
  }
}
