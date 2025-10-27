import 'package:genesis/src/features/dbaas/domain/params/pg_users/pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';

final class DeletePgUserUseCase {
  DeletePgUserUseCase(this._repository);

  final IPgUsersRepository _repository;

  Future<void> call(PgUserParams params) {
    return _repository.deletePgUser(params);
  }
}
