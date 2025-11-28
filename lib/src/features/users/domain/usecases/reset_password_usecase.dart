import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';

final class ResetPasswordUsecase {
  ResetPasswordUsecase(this._repository);

  // ignore: unused_field
  final IUsersRepository _repository;

  Future<void> call() async {}
}