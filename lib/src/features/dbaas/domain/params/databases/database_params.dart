import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';

final class DatabaseParams {
  DatabaseParams({
    required this.instanceId,
    required this.databaseId,
  });

  final ClusterID instanceId;
  final DatabaseID databaseId;
}