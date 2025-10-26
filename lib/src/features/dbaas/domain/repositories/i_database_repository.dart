import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/create_database_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/database_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/get_databases_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/update_database_params.dart';

abstract interface class IDatabaseRepository {
  Future<Database> getDatabase(DatabaseParams params);

  Future<List<Database>> getDatabases(GetDatabasesParams params);

  Future<Database> createDatabase(CreateDatabaseParams params);

  Future<Database> updateDatabase(UpdateDatabaseParams params);

  Future<void> deleteDatabase(DatabaseParams params);
}
