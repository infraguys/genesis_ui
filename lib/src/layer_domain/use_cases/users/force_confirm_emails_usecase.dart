import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/confirm_email_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';

final class ForceConfirmEmailUseCase {
  ForceConfirmEmailUseCase(this._repository);

  final IUsersRepository _repository;

  Future<User> call(ConfirmEmailParams params) async {
    return await _repository.forceConfirmEmail(params);
  }
}

final class ForceConfirmEmailsUseCase {
  ForceConfirmEmailsUseCase(this._repository);

  final IUsersRepository _repository;

  Future<List<User>> call(List<ConfirmEmailParams> listOfParams) async {
    return await Future.wait(
      listOfParams.where((it) => !it.verified).map(_repository.forceConfirmEmail),
    );
  }
}
