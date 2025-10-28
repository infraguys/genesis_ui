import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';

final class PgUserParams {
  PgUserParams({
    required this.pgInstanceId,
    required this.pgUserId,
  });

  final PgInstanceID pgInstanceId;
  final PgUserID pgUserId;
}
