import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';

final class GetPgUsersParams {
  GetPgUsersParams({required this.clusterId});

  final ClusterID clusterId;
}
