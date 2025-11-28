import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/force_confirm_email_params.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

final class ForceConfirmEmailsUseCase {
  ForceConfirmEmailsUseCase(this._repository);

  final IUsersRepository _repository;

  Future<List<User>> call(List<User> users) async {
    final unverifiedUsers = users.where((user) => !user.emailVerified);

    return await Future.wait(
      unverifiedUsers.map(
        (user) => _repository.forceConfirmEmail(ForceConfirmEmailParams(user.uuid)),
      ),
    );
  }
}
