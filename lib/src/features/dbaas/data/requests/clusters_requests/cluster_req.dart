import 'package:genesis/src/core/network/endpoints/clusters_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/cluster_params.dart';

extension ClusterReq on ClusterParams {
  String toPath() {
    return ClustersEndpoints.item(id).fullPath;
  }
}
