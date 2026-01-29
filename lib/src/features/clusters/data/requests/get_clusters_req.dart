import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/clusters_endpoints.dart';
import 'package:genesis/src/features/clusters/data/json_converters/cluster_status_converter.dart';
import 'package:genesis/src/features/clusters/domain/params/get_clusters_params.dart';

final class GetClustersReq extends IRequest {
  const GetClustersReq(this._params);

  final GetClustersParams _params;

  @override
  Map<String, dynamic> get query {
    return {
      'uuid': ?_params.id,
      'name': ?_params.name,
      'description': ?_params.description,
      'project_id': ?_params.projectId,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
      'status': ?ClusterStatusConverter().toJson(_params.status),
      'cpu': ?_params.cores,
      'ram': ?_params.ram,
      'disk_size': ?_params.diskSize,
      'nodes_number': ?_params.nodesNumber,
      'sync_replica_number': ?_params.syncReplicaNumber,
      'version': ?_params.version,
    };
  }

  @override
  String get path {
    return ClustersEndpoints.items().fullPath;
  }
}
