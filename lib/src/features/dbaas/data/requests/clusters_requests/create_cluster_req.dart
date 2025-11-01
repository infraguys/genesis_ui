import 'package:genesis/src/core/network/endpoints/clusters_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/db_versions_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/create_cluster_params.dart';

extension CreateClusterReq on CreateClusterParams {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'cpu': cores,
      'ram': ram,
      'disk_size': diskSize,
      'nodes_number': nodesNumber,
      'sync_replica_number': syncReplicaNumber,
      'version': DbVersionsEndpoints.item(dbVersionId).relativePath,
    };
  }

  String toPath() {
    return ClustersEndpoints.items().fullPath;
  }
}
