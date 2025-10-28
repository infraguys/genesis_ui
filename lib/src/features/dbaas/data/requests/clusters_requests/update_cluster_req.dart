import 'package:genesis/src/core/network/endpoints/pg_instances_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/update_cluster_params.dart';

extension UpdatePgInstanceReq on UpdateClusterParams {
  Map<String, dynamic> toJson() {
    return {
      'name': ?name,
      'description': ?description,
      'ipsv4': ?ipsv4,
      'cpu': ?cores,
      'ram': ?ram,
      'disk_size': ?diskSize,
      'nodes_number': ?nodesNumber,
      'sync_replica_number': ?syncReplicaNumber,
    };
  }

  String toPath() {
    return PgInstancesEndpoints.item(id).fullPath;
  }
}
