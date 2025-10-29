import 'package:equatable/equatable.dart';

class Cluster extends Equatable {
  const Cluster({
    required this.id,
    required this.name,
    required this.description,
    required this.projectId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.ipsv4,
    required this.cores,
    required this.ram,
    required this.diskSize,
    required this.nodesNumber,
    required this.syncReplicaNumber,
    required this.version,
  });

  final ClusterID id;
  final String name;
  final String? description;
  final String projectId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ClusterStatus status;
  final List<String> ipsv4;
  final int cores;
  final int ram;
  final int diskSize;
  final int nodesNumber;
  final int syncReplicaNumber;
  final String version;

  @override
  List<Object?> get props => [
    name,
    description,
    projectId,
    createdAt,
    updatedAt,
    status,
    ipsv4,
    cores,
    ram,
    diskSize,
    nodesNumber,
    syncReplicaNumber,
    version,
  ];
}

extension type ClusterID(String raw) {}

/// ACTIVE, ERROR, IN_PROGRESS, NEW
enum ClusterStatus { newStatus, active, error, inProgress, unknown }
