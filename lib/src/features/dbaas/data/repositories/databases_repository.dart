import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';

final class DatabasesRepository implements IDatabaseRepository {
  @override
  Future<Database> createDatabase(params) {
    // TODO: implement createDatabase
    throw UnimplementedError();
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
  Future<List<Database>> getDatabases(params) {
    // TODO: implement getDatabases
    throw UnimplementedError();
  }

  @override
  Future<Database> updateDatabase(params) {
    // TODO: implement updateDatabase
    throw UnimplementedError();
  }
}
