import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/clusters_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/db_versions_endpoints.dart';
import 'package:genesis/src/features/clusters/domain/params/create_cluster_params.dart';

final class CreateClusterReq extends IRequest {
  CreateClusterReq(this._params);

  final CreateClusterParams _params;

  @override
  Map<String, dynamic> get body {
    return {
      'name': _params.name,
      'description': _params.description,
      'cpu': _params.cores,
      'ram': _params.ram,
      'disk_size': _params.diskSize,
      'nodes_number': _params.nodesNumber,
      'sync_replica_number': _params.syncReplicaNumber,
      'version': DbVersionsEndpoints.item(_params.dbVersionId).relativePath,
    };
  }

  @override
  String get path {
    return ClustersEndpoints.items().fullPath;
  }
}
