import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';

final class GetPgUsersParams {
  GetPgUsersParams({required this.pgInstanceId});

  final PgInstanceID pgInstanceId;
}
