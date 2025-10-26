import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';

final class GetDatabaseParams {
  GetDatabaseParams({
    required this.instanceId,
    required this.databaseId,
  });

  final PgInstanceID instanceId;
  final DatabaseID databaseId;
}
