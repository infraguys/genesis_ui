import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';

final class UpdateClusterParams {
  UpdateClusterParams({
    required this.id,
    required this.name,
    required this.cores,
    required this.ram,
    required this.diskSize,
    required this.nodesNumber,
    required this.syncReplicaNumber,
    this.description,
  });

  final ClusterID id;
  final String? name;
  final String? description;
  final int? cores;
  final int? ram;
  final int? diskSize;
  final int? nodesNumber;
  final int? syncReplicaNumber;
}
