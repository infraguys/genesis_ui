import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';

final class GetPgInstanceParams {
  GetPgInstanceParams(this.id);

  final PgInstanceID id;
}
