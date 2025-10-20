import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';

abstract class PgInstancesEndpoints {
  static Endpoint items() {
    return Endpoint.withDbaasPrefix('/types/postgres/instances/');
  }

  static Endpoint item(PgInstanceID id) {
    return Endpoint.withDbaasPrefix('/types/postgres/instances/$id');
  }
}
