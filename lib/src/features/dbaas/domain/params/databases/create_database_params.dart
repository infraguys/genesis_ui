import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';

final class CreateDatabaseParams {
  CreateDatabaseParams({
    required this.instanceId,
    required this.name,
    required this.pgUserId,
    required this.description,
  });

  final ClusterID instanceId;
  final PgUserID pgUserId;
  final String name;
  final String? description;
}
