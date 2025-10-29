import 'package:genesis/src/features/dbaas/data/requests/database_requests/get_pg_databases_req.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/databases_api.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';

final class PgDatabasesRepository implements IDatabaseRepository {
  PgDatabasesRepository(this._api);

  final PgDatabasesApi _api;

  @override
  Future<Database> createDatabase(params) async {
    final dto = await _api.createDatabase(params);
    return dto.toEntity();
  }

  @override
  Future<void> deleteDatabase(params) async {
    await _api.deleteDatabase(params);
  }

  @override
  Future<Database> getDatabase(params) async {
    final dto = await _api.getDatabase(params);
    return dto.toEntity();
  }

  @override
  Future<List<Database>> getDatabases(params) async {
    final dtos = await _api.getDatabases(GetPgDatabasesReq(params));
    return dtos.map((it) => it.toEntity()).toList();
  }

  @override
  Future<Database> updateDatabase(params) {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }
}
