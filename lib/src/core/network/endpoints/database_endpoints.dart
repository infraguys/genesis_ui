import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';

abstract class DatabaseEndpoints {
  static Endpoint items(ClusterID pgInstanceId) {
    return Endpoint.withDbaasPrefix('/types/postgres/instances/$pgInstanceId/databases/');
  }

  static Endpoint item(ClusterID pgInstanceId, DatabaseID dbId) {
    return Endpoint.withDbaasPrefix('/types/postgres/instances/$pgInstanceId/databases/$dbId');
  }
}
