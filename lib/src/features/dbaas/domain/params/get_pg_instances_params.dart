import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';

final class GetPgInstancesParams {
  const GetPgInstancesParams({
    this.id,
    this.name,
    this.description,
    this.projectId,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.cores,
    this.ram,
    this.diskSize,
    this.nodesNumber,
    this.syncReplicaNumber,
    this.version,
  });

  final PgInstanceID? id;
  final String? name;
  final String? description;
  final String? projectId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PgInstanceStatus? status;
  final int? cores;
  final int? ram;
  final int? diskSize;
  final int? nodesNumber;
  final int? syncReplicaNumber;
  final String? version;
}
