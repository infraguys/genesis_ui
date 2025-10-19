import 'package:genesis/src/core/network/endpoints/pg_instances_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';

final class GetPgInstanceReq {
  GetPgInstanceReq(this.id);

  final PgInstanceID id;

  String toPath() => PgInstancesEndpoints.getInstance(id);
}
