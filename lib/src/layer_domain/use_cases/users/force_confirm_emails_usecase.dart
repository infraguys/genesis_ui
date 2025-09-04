import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

final class ForceConfirmEmailUseCase {
  ForceConfirmEmailUseCase(this._repository);

  final IUsersRepository _repository;

  Future<User> call(UserUUID uuid) async {
    return await _repository.forceConfirmEmail(uuid);
  }
}

final class ForceConfirmEmailsUseCase {
  ForceConfirmEmailsUseCase(this._repository);

  final IUsersRepository _repository;

  Future<List<User>> call(List<UserUUID> uuids) async {
    return await Future.wait(uuids.map(_repository.forceConfirmEmail));
  }
}
