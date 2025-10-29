import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';

final class UpdatePgUserParams {
  UpdatePgUserParams({
    required this.pgInstanceId,
    required this.pgUserId,
    this.description,
    this.password,
  });

  final ClusterID pgInstanceId;
  final PgUserID pgUserId;
  final String? description;
  final String? password;
}
