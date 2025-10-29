import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';

final class GetPgUserUseCase {
  GetPgUserUseCase(this._repository);

  final IPgUsersRepository _repository;

  Future<PgUser> call(PgUserParams params) {
    return _repository.getPgUser(params);
  }
}
