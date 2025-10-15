import 'package:genesis/src/core/network/endpoints/pg_instances_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/create_pg_instance_params.dart';

extension CreatePgInstanceReqExt on CreatePgInstanceParams {
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
      'version': '/v1/types/postgres/versions/26786c09-d175-44e5-9013-ac14c88acd1c',
    };
  }

  String toPath() => PgInstancesEndpoints.createInstance();
}
