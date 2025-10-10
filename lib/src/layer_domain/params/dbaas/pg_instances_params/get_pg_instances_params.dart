import 'package:genesis/src/layer_domain/entities/pg_instance.dart';

final class GetPgInstancesParams {
  GetPgInstancesParams({
    this.uuid,
    this.name,
    this.description,
    this.projectId,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.cpu,
    this.ram,
    this.diskSize,
    this.nodesNumber,
    this.syncReplicaNumber,
    this.version,
  });

  final PGInstanceUUID? uuid;
  final String? name;
  final String? description;
  final String? projectId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PgInstanceStatus? status;
  final int? cpu;
  final int? ram;
  final int? diskSize;
  final int? nodesNumber;
  final int? syncReplicaNumber;
  final String? version;
}
