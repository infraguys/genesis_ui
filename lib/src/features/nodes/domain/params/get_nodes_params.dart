import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';

final class GetNodesParams {
  const GetNodesParams({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.projectId,
    this.name,
    this.description,
    this.cores,
    this.ram,
    this.rootDiskSize,
    this.image,
    this.status,
    this.nodeType,
  });

  final NodeID? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProjectID? projectId;
  final String? name;
  final String? description;
  final int? cores;
  final int? ram;
  final int? rootDiskSize;
  final String? image;
  final NodeStatus? status;
  final NodeType? nodeType;
}
