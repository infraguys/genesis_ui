import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/core/network/endpoints/pg_instances_endpoints.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:genesis/src/layer_domain/params/dbaas/pg_instances_params/get_pg_instances_params.dart';

final class GetPgInstancesReq implements QueryEncodable, PathEncodable {
  GetPgInstancesReq(this._params);

  final GetPgInstancesParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {
      'uuid': ?_params.uuid?.raw,
      'name': ?_params.name,
      'description': ?_params.description,
      'project_id': ?_params.projectId,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
      'status': ?_fromStatus(_params.status),
      'cpu': ?_params.cpu?.toString(),
      'ram': ?_params.ram?.toString(),
      'disk_size': ?_params.diskSize?.toString(),
      'nodes_number': ?_params.nodesNumber?.toString(),
      'sync_replica_number': ?_params.syncReplicaNumber?.toString(),
      'version': ?_params.version,
    };
  }

  @override
  String toPath() {
    return PGInstancesEndpoints.getInstances();
  }

  String? _fromStatus(PgInstanceStatus? status) {
    return switch (status) {
      PgInstanceStatus.active => 'ACTIVE',
      PgInstanceStatus.error => 'ERROR',
      PgInstanceStatus.inProgress => 'IN_PROGRESS',
      PgInstanceStatus.newStatus => 'NEW',
      _ => null,
    };
  }
}
