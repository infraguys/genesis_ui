import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

final class ConfirmEmailUseCase {
  ConfirmEmailUseCase(this._repository);

  final IUsersRepository _repository;

  Future<User> call(UserUUID params) async {
    return await _repository.confirmEmail(params);
  }
}

final class ConfirmEmailsUseCase {
  ConfirmEmailsUseCase(this._repository);

  final IUsersRepository _repository;

  Future<List<User>> call(List<User> params) async {
    return await Future.wait(
      params.map((user) => _repository.confirmEmail(user.uuid)),
    );
  }
}
