import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/create_pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';

final class CreatePgUserUseCase {
  CreatePgUserUseCase(this._repository);

  final IPgUsersRepository _repository;

  Future<PgUser> call(CreatePgUserParams params) {
    return _repository.createPgUser(params);
  }
}
