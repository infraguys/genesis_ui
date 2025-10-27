import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/update_pg_users_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';

final class UpdatePgUserUseCase {
  UpdatePgUserUseCase(this._repository);

  final IPgUsersRepository _repository;

  Future<PgUser> call(UpdatePgUsersParams params) {
    return _repository.updatePgUser(params);
  }
}
