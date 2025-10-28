import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';

final class UpdateDatabaseParams {
  UpdateDatabaseParams({
    required this.pgInstanceId,
    required this.databaseId,
    required this.name,
    // required this.owner,
    this.description,
  });

  final PgInstanceID pgInstanceId;
  final DatabaseID databaseId;
  final String name;
  // final String owner;
  final String? description;
}
