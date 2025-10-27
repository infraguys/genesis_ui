import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';

abstract class DatabasesEndpoints {
  static Endpoint items(PgInstanceID pgInstanceId) {
    return Endpoint.withDbaasPrefix('/types/postgres/instances/$pgInstanceId/databases/');
  }

  static Endpoint item(PgInstanceID pgInstanceId, DatabaseID dbId) {
    return Endpoint.withDbaasPrefix('/types/postgres/instances/$pgInstanceId/databases/$dbId');
  }
}
