import 'package:genesis/src/features/dbaas/domain/params/pg_users/pg_user_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';

final class DeletePgUsersUseCase {
  DeletePgUsersUseCase(this._repository);

  final IPgUsersRepository _repository;

  Future<void> call(List<PgUserParams> listOfParams) {
    return Future.wait(listOfParams.map(_repository.deletePgUser));
  }
}
