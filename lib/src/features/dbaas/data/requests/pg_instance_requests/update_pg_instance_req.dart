import 'package:genesis/src/core/network/endpoints/pg_instances_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_instances/update_pg_instance_params.dart';

final class UpdatePgInstanceReq {
  UpdatePgInstanceReq(this._params);

  final UpdatePgInstanceParams _params;

  Map<String, dynamic> toJson() {
    return {
      'name': ?_params.name,
      'description': ?_params.description,
      'ipsv4': ?_params.ipsv4,
      'cpu': ?_params.cores,
      'ram': ?_params.ram,
      'disk_size': ?_params.diskSize,
      'nodes_number': ?_params.nodesNumber,
      'sync_replica_number': ?_params.syncReplicaNumber,
    };
  }

  String toPath() {
    return PgInstancesEndpoints.item(_params.id).fullPath;
  }
}
