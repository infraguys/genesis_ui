import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/get_pg_users_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';

final class GetPgUsersUseCase {
  GetPgUsersUseCase(this._repository);

  final IPgUsersRepository _repository;

  Future<List<PgUser>> call(GetPgUsersParams params) {
    return _repository.getPgUsers(params);
  }
}
