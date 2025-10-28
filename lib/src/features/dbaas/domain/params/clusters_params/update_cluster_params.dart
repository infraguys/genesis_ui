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
    required this.ipsv4,
    this.description,
  });

  final ClusterID id;
  final String? name;
  final String? description;
  final List<String>? ipsv4;
  final int? cores;
  final int? ram;
  final int? diskSize;
  final int? nodesNumber;
  final int? syncReplicaNumber;
}
