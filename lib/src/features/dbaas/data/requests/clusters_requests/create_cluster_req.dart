import 'package:genesis/src/core/network/endpoints/clusters_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/create_cluster_params.dart';

extension CreateClusterReq on CreateClusterParams {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'ipsv4': ipsv4,
      'cpu': cores,
      'ram': ram,
      'disk_size': diskSize,
      'nodes_number': nodesNumber,
      'sync_replica_number': syncReplicaNumber,
      'version': versionLink,
    };
  }

  String toPath() {
    return ClustersEndpoints.items().fullPath;
  }
}
