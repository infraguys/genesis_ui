import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/nodes/data/json_converters/node_id_converter.dart';
import 'package:genesis/src/features/nodes/data/json_converters/node_status_converter.dart';
import 'package:genesis/src/features/nodes/data/json_converters/node_type_converter.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/projects/data/json_converters/project_id_converter.dart';
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

  @NodeIdConverter()
  @JsonKey(name: 'uuid')
  final NodeID id;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @ProjectIdConverter()
  @JsonKey(name: 'project_id')
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
  @NodeStatusConverter()
  @JsonKey(name: 'status')
  final NodeStatus status;
  @NodeTypeConverter()
  @JsonKey(name: 'node_type')
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

  static String _ipv4FromDefaultNetwork(Map<String, dynamic> defaultNetwork) {
    return defaultNetwork['ipv4'] as String? ?? '';
  }

}
