import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';

final class PgUserParams {
  PgUserParams({
    required this.pgInstanceId,
    required this.pgUserId,
  });

  final ClusterID pgInstanceId;
  final PgUserID pgUserId;
}
