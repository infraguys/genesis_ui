import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';

abstract class ClustersEndpoints {
  static Endpoint items() {
    return Endpoint.withDbaasPrefix('/types/postgres/instances/');
  }

  static Endpoint item(ClusterID id) {
    return Endpoint.withDbaasPrefix('/types/postgres/instances/$id');
  }
}
