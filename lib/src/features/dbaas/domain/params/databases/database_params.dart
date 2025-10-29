import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';

final class DatabaseParams {
  DatabaseParams({
    required this.clusterId,
    required this.databaseId,
  });

  final ClusterID clusterId;
  final DatabaseID databaseId;
}