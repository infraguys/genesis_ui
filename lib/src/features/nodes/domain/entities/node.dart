import 'package:equatable/equatable.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';

class Node extends Equatable {
  const Node({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.projectId,
    required this.name,
    required this.description,
    required this.cores,
    required this.ram,
    required this.rootDiskSize,
    required this.image,
    required this.status,
    required this.nodeType,
    required this.ipv4,
  });

  final NodeID id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProjectID projectId;
  final String name;
  final String description;
  final int cores;
  final int ram;
  final int rootDiskSize;
  final String image;
  final NodeStatus status;
  final NodeType nodeType;
  final String ipv4;

  @override
  List<Object?> get props => [
    id,
    createdAt,
    updatedAt,
    projectId,
    name,
    description,
    cores,
    ram,
    rootDiskSize,
    image,
    status,
    nodeType,
    ipv4,
  ];
}

extension type NodeID(String value) {
  bool isEqualTo(NodeID other) => value == other.value;
}

enum NodeType {
  hw,
  vm,
  unknown,
}

/// ACTIVE, ERROR, IN_PROGRESS, NEW, SCHEDULED, STARTED
enum NodeStatus { newStatus, active, error, inProgress, scheduled, started, unknown }
