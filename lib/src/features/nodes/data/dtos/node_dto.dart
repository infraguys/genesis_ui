import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node_dto.g.dart';

@JsonSerializable(constructor: '_')
final class NodeDto implements IDto<Node> {
  NodeDto._({
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

  factory NodeDto.fromJson(Map<String, dynamic> json) => _$NodeDtoFromJson(json);

  @JsonKey(name: 'uuid', fromJson: _toID)
  final NodeID id;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'project_id', fromJson: _toProjectID)
  final ProjectID projectId;
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
  @JsonKey(name: 'status', fromJson: _toStatusFromJson)
  final NodeStatus status;
  @JsonKey(name: 'node_type', fromJson: _toNodeTypeFromJson)
  final NodeType nodeType;
  @JsonKey(name: 'default_network', fromJson: _ipv4FromDefaultNetwork)
  final String ipv4;

  @override
  Node toEntity() {
    return Node(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      projectId: projectId,
      name: name,
      description: description,
      cores: cores,
      ram: ram,
      rootDiskSize: rootDiskSize,
      image: image,
      status: status,
      nodeType: nodeType,
      ipv4: ipv4,
    );
  }

  static NodeID _toID(String json) => NodeID(json);

  static ProjectID _toProjectID(String json) => ProjectID(json);

  static String _ipv4FromDefaultNetwork(Map<String, dynamic> defaultNetwork) {
    return defaultNetwork['ipv4'] as String? ?? '';
  }

  static NodeStatus _toStatusFromJson(String json) => switch (json) {
    'NEW' => NodeStatus.newStatus,
    'ACTIVE' => NodeStatus.active,
    'IN_PROGRESS' => NodeStatus.inProgress,
    'ERROR' => NodeStatus.error,
    'SCHEDULED' => NodeStatus.scheduled,
    'STARTED' => NodeStatus.started,
    _ => NodeStatus.unknown,
  };

  static NodeType _toNodeTypeFromJson(String json) => switch (json) {
    'HW' => NodeType.hw,
    'VM' => NodeType.vm,
    _ => NodeType.unknown,
  };
}
