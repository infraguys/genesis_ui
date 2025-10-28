import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';

final class GetClustersParams {
  const GetClustersParams({
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

  final ClusterID? id;
  final String? name;
  final String? description;
  final String? projectId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ClusterStatus? status;
  final int? cores;
  final int? ram;
  final int? diskSize;
  final int? nodesNumber;
  final int? syncReplicaNumber;
  final String? version;
}
