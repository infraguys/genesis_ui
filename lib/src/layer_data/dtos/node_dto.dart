// ignore_for_file: library_private_types_in_public_api

import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_data/dtos/node_type_dto.dart';
import 'package:genesis/src/layer_domain/entities/node.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node_dto.g.dart';

@JsonSerializable(constructor: '_')
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
    required this.ipv4,
  });

  factory NodeDto.fromJson(Map<String, dynamic> json) => _$NodeDtoFromJson(json);

  @JsonKey(name: 'uuid')
  final String uuid;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'project_id')
  final String projectId;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'cores')
  final int cores;
  @JsonKey(name: 'ram')
  final int ram;
  @JsonKey(name: 'root_disk_size')
  final int rootDiskSize;
  @JsonKey(name: 'image')
  final String image;
  @JsonKey(name: 'status', fromJson: _statusFromJson)
  final NodeStatus status;
  @JsonKey(name: 'node_type')
  final NodeTypeDto nodeType;
  @JsonKey(name: 'default_network', fromJson: _ipv4FromDefaultNetwork, defaultValue: '')
  final String ipv4;

  @override
  Node toEntity() {
    return Node(
      uuid: NodeUUID(uuid),
      createdAt: createdAt,
      updatedAt: updatedAt,
      projectId: ProjectID(projectId),
      name: name,
      description: description,
      cores: cores,
      ram: ram,
      rootDiskSize: rootDiskSize,
      image: image,
      status: status,
      nodeType: nodeType.toDomain(),
      ipv4: ipv4,
    );
  }

  static String _ipv4FromDefaultNetwork(Map<String, dynamic>? defaultNetwork) {
    return defaultNetwork?['ipv4'] as String;
  }

  static NodeStatus _statusFromJson(String json) => switch (json) {
    'NEW' => NodeStatus.newStatus,
    'ACTIVE' => NodeStatus.active,
    'IN_PROGRESS' => NodeStatus.inProgress,
    'ERROR' => NodeStatus.error,
    'SCHEDULED' => NodeStatus.scheduled,
    'STARTED' => NodeStatus.started,
    _ => NodeStatus.unknown,
  };
}
