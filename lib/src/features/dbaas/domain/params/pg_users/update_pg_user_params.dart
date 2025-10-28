import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';

final class UpdatePgUserParams {
  UpdatePgUserParams({
    required this.pgInstanceId,
    required this.pgUserId,
    this.description,
    this.password,
  });

  final PgInstanceID pgInstanceId;
  final PgUserID pgUserId;
  final String? description;
  final String? password;
}
