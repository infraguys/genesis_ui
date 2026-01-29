import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/clusters_endpoints.dart';
import 'package:genesis/src/features/clusters/domain/params/update_cluster_params.dart';

final class UpdateClusterReq extends IRequest {
  const UpdateClusterReq(this._params);

  final UpdateClusterParams _params;

  @override
  Map<String, dynamic> get body {
    return {
      'name': ?_params.name,
      'description': ?_params.description,
      'cpu': ?_params.cores,
      'ram': ?_params.ram,
      'disk_size': ?_params.diskSize,
      'nodes_number': ?_params.nodesNumber,
      'sync_replica_number': ?_params.syncReplicaNumber,
    };
  }

  @override
  String get path {
    return ClustersEndpoints.item(_params.id).fullPath;
  }
}
