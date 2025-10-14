import 'package:genesis/src/core/network/endpoints/pg_instances_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/update_pg_instance_params.dart';

extension CreatePgInstanceReqExt on UpdatePgInstanceParams {
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

  String toPath() => PgInstancesEndpoints.updateInstance(id);
}
