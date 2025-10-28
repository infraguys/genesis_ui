import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';

final class GetDatabasesParams {
  GetDatabasesParams({
    required this.instanceId,
  });

  final ClusterID instanceId;
}
