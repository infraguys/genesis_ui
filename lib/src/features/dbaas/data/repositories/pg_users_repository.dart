import 'package:genesis/src/features/dbaas/data/source/remote/pg_users_api.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';

final class PgUsersRepository implements IPgUsersRepository {
  PgUsersRepository(this._api);

  final PgUsersApi _api;

  @override
  Future<PgUser> createPgUser(params) async {
    final dto = await _api.createPgUser(params);
    return dto.toEntity();
  }

  @override
  Future<void> deletePgUser(params) async {
    await _api.deletePgUser(params);
  }

  @override
  Future<PgUser> getPgUser(params) async {
    final dto = await _api.getPgUser(params);
    return dto.toEntity();
  }

  @override
  Future<List<PgUser>> getPgUsers(params) async {
    final dtos = await _api.getPgUsers(params);
    return dtos.map((it) => it.toEntity()).toList();
  }

  @override
  Future<PgUser> updatePgUser(params) async {
    final dto = await _api.updatePgUser(params);
    return dto.toEntity();
  }
}
