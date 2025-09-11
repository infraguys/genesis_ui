import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';

final class GetNodesParams {
  GetNodesParams({
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

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProjectUUID? projectId;
  final String? name;
  final String? description;
  final int? cores;
  final int? ram;
  final int? rootDiskSize;
  final String? image;
  final NodeStatus? status;
  final NodeType? nodeType;
}
