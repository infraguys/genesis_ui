import 'package:genesis/src/features/clusters/domain/entities/cluster.dart';

final class GetDatabasesParams {
  GetDatabasesParams({
    required this.clusterId,
  });

  final ClusterID clusterId;
}
