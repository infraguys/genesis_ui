import 'package:genesis/src/core/network/endpoints/pg_instances_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/params/get_pg_instances_params.dart';

final class GetPgInstancesReq {
  GetPgInstancesReq(this._params);

  final GetPgInstancesParams _params;

  Map<String, dynamic> toQuery() {
    return {
      'uuid': ?_params.id,
      'name': ?_params.name,
      'description': ?_params.description,
      'project_id': ?_params.projectId,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
      'status': ?_fromStatusToQuery(_params.status),
      'cpu': ?_params.cores,
      'ram': ?_params.ram,
      'disk_size': ?_params.diskSize,
      'nodes_number': ?_params.nodesNumber,
      'sync_replica_number': ?_params.syncReplicaNumber,
      'version': ?_params.version,
    };
  }

  String? _fromStatusToQuery(PgInstanceStatus? status) => switch (status) {
    PgInstanceStatus.active => 'ACTIVE',
    PgInstanceStatus.error => 'ERROR',
    PgInstanceStatus.inProgress => 'IN_PROGRESS',
    PgInstanceStatus.newStatus => 'NEW',
    _ => null,
  };

  String toPath() {
    return PgInstancesEndpoints.items().fullPath;
  }
}
