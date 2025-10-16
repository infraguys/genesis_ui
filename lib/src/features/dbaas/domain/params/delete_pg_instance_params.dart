import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';

final class DeletePgInstanceParams {
  const DeletePgInstanceParams(this.id);

  final PgInstanceID id;
}
