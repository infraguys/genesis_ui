import 'package:genesis/src/core/network/endpoints/clusters_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/params/clusters_params/get_clusters_params.dart';

extension GetClustersReq on GetClustersParams {
  Map<String, dynamic> toQuery() {
    return {
      'uuid': ?id,
      'name': ?name,
      'description': ?description,
      'project_id': ?projectId,
      'created_at': ?createdAt?.toIso8601String(),
      'updated_at': ?updatedAt?.toIso8601String(),
      'status': ?_fromStatusToQuery(status),
      'cpu': ?cores,
      'ram': ?ram,
      'disk_size': ?diskSize,
      'nodes_number': ?nodesNumber,
      'sync_replica_number': ?syncReplicaNumber,
      'version': ?version,
    };
  }

  String? _fromStatusToQuery(ClusterStatus? status) => switch (status) {
    ClusterStatus.active => 'ACTIVE',
    ClusterStatus.error => 'ERROR',
    ClusterStatus.inProgress => 'IN_PROGRESS',
    ClusterStatus.newStatus => 'NEW',
    _ => null,
  };

  String toPath() {
    return ClustersEndpoints.items().fullPath;
  }
}
