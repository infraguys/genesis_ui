import 'package:genesis/src/core/network/endpoints/clusters_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/update_cluster_params.dart';

extension UpdatePgInstanceReq on UpdateClusterParams {
  Map<String, dynamic> toJson() {
    return {
      'name': ?name,
      'description': ?description,
      'cpu': ?cores,
      'ram': ?ram,
      'disk_size': ?diskSize,
      'nodes_number': ?nodesNumber,
      'sync_replica_number': ?syncReplicaNumber,
    };
  }

  String toPath() {
    return ClustersEndpoints.item(id).fullPath;
  }
}
