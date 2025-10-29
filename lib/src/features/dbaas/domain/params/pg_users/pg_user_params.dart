import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';

final class PgUserParams {
  PgUserParams({
    required this.clusterId,
    required this.pgUserId,
  });

  final ClusterID clusterId;
  final PgUserID pgUserId;
}
