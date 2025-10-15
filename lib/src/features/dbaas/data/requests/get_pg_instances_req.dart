import 'package:genesis/src/core/network/endpoints/pg_instances_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/params/get_pg_instances_params.dart';

extension GetPgInstancesReqExt on GetPgInstancesParams {
  Map<String, dynamic> toQuery() {
    return {
      'uuid': ?id,
      'name': ?name,
      'description': ?description,
      'project_id': ?projectId,
      'created_at': ?createdAt?.toIso8601String(),
      'updated_at': ?updatedAt?.toIso8601String(),
      'status': ?_fromStatus(status),
      'cpu': ?cores,
      'ram': ?ram,
      'disk_size': ?diskSize,
      'nodes_number': ?nodesNumber,
      'sync_replica_number': ?syncReplicaNumber,
      'version': ?version,
    };
  }

  String? _fromStatus(PgInstanceStatus? status) => switch (status) {
    PgInstanceStatus.active => 'ACTIVE',
    PgInstanceStatus.error => 'ERROR',
    PgInstanceStatus.inProgress => 'IN_PROGRESS',
    PgInstanceStatus.newStatus => 'NEW',
    _ => null,
  };

  String toPath() => PgInstancesEndpoints.createInstance();
}
