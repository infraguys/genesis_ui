// ignore_for_file: library_private_types_in_public_api

import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_data/dtos/node_type_dto.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node_dto.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
final class NodeDto implements IDto<Node> {
  NodeDto._({
    required this.uuid,
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
  });

  factory NodeDto.fromJson(Map<String, dynamic> json) => _$NodeDtoFromJson(json);

  final String uuid;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  final String projectId;
  final String name;
  final String description;
  final int cores;
  final int ram;
  final int rootDiskSize;
  final String image;
  final _StatusDto status;
  final NodeTypeDto nodeType;

  @override
  Node toEntity() {
    return Node(
      uuid: NodeUUID(uuid),
      createdAt: createdAt,
      updatedAt: updatedAt,
      projectId: ProjectUUID(projectId),
      name: name,
      description: description,
      cores: cores,
      ram: ram,
      rootDiskSize: rootDiskSize,
      image: image,
      status: status.toNodeStatus(),
      nodeType: nodeType.toDomain(),
    );
  }
}

/// ACTIVE, ERROR, IN_PROGRESS, NEW, SCHEDULED, STARTED
@JsonEnum()
enum _StatusDto {
  @JsonValue('NEW')
  newStatus,
  @JsonValue('ACTIVE')
  active,
  @JsonValue('ERROR')
  error,
  @JsonValue('IN_PROGRESS')
  inProgress,
  @JsonValue('SCHEDULED')
  scheduled,
  @JsonValue('STARTED')
  started;

  NodeStatus toNodeStatus() => switch (this) {
    newStatus => NodeStatus.newStatus,
    active => NodeStatus.active,
    error => NodeStatus.error,
    inProgress => NodeStatus.inProgress,
    scheduled => NodeStatus.scheduled,
    started => NodeStatus.started,
  };
}

// @JsonEnum()
// enum _NodeTypeDto {
//   @JsonValue('HW')
//   hw,
//   @JsonValue('VM')
//   vm;
//
//   NodeType toNodeType() => switch (this) {
//     hw => NodeType.hw,
//     vm => NodeType.vm,
//   };
// }

/// ACTIVE, ERROR, IN_PROGRESS, NEW, SCHEDULED, STARTED
