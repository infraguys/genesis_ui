import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';

final class GetDatabasesParams {
  GetDatabasesParams({
    required this.instanceId,
  });

  final PgInstanceID instanceId;
}
