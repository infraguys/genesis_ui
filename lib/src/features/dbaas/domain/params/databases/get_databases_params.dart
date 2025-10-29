import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';

final class GetDatabasesParams {
  GetDatabasesParams({
    required this.clusterId,
  });

  final ClusterID clusterId;
}
