import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';

final class CreateDatabaseParams {
  CreateDatabaseParams({
    required this.instanceId,
    required this.name,
    required this.owner,
    required this.description,
  });

  final PgInstanceID instanceId;
  final String name;
  final String owner;
  final String? description;
}
