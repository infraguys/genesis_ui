import 'package:genesis/src/features/dbaas/data/requests/database_requests/create_database_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/database_requests/get_databases_req.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/databases_api.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';

final class DatabasesRepository implements IDatabaseRepository {
  DatabasesRepository(this._databasesApi);

  final DatabasesApi _databasesApi;

  @override
  Future<Database> createDatabase(params) async {
    final dto = await _databasesApi.createDatabase(CreateDatabaseReq(params));
    return dto.toEntity();
  }

  @override
  Future<void> deleteDatabase(params) {
    // TODO: implement deleteDatabase
    throw UnimplementedError();
  }

  @override
  Future<Database> getDatabase(params) {
    // TODO: implement getDatabase
    throw UnimplementedError();
  }

  @override
  Future<List<Database>> getDatabases(params) async {
    final dtos = await _databasesApi.getDatabases(GetDatabasesReq(params));
    return dtos.map((it) => it.toEntity()).toList();
  }

  @override
  Future<Database> updateDatabase(params) {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }
}
