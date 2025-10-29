import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';

abstract class DatabaseUserEndpoints {
  static Endpoint items(ClusterID pgInstanceId) {
    return Endpoint.withDbaasPrefix('/types/postgres/instances/$pgInstanceId/users/');
  }

  static Endpoint item(ClusterID pgInstanceId, PgUserID pgUserId) {
    return Endpoint.withDbaasPrefix('/types/postgres/instances/$pgInstanceId/users/$pgUserId');
  }
}
