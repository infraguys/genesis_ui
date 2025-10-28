import 'package:genesis/src/core/network/endpoints/pg_instances_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/cluster_params.dart';

extension ClusterReq on ClusterParams {
  String toPath() {
    return PgInstancesEndpoints.item(id).fullPath;
  }
}
