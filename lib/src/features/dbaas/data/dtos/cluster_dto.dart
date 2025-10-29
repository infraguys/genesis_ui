import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cluster_dto.g.dart';

@JsonSerializable(constructor: '_')
final class ClusterDto implements IDto<Cluster> {
  ClusterDto._({
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

  factory ClusterDto.fromJson(Map<String, dynamic> json) => _$ClusterDtoFromJson(json);

  @JsonKey(name: 'uuid', fromJson: _toID)
  final ClusterID id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(name: 'project_id')
  final String projectId;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'status', fromJson: _toStatusFromJson)
  final ClusterStatus status;
  @JsonKey(name: 'ipsv4')
  final List<String> ipsv4;
  @JsonKey(name: 'cpu')
  final int cores;
  @JsonKey(name: 'ram')
  final int ram;
  @JsonKey(name: 'disk_size')
  final int diskSize;
  @JsonKey(name: 'nodes_number')
  final int nodesNumber;
  @JsonKey(name: 'sync_replica_number')
  final int syncReplicaNumber;
  @JsonKey(name: 'version')
  final String version;

  @override
  Cluster toEntity() {
    return Cluster(
      id: id,
      name: name,
      description: description,
      projectId: projectId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      ipsv4: ipsv4,
      cores: cores,
      ram: ram,
      diskSize: diskSize,
      nodesNumber: nodesNumber,
      syncReplicaNumber: syncReplicaNumber,
      version: version,
    );
  }

  static ClusterID _toID(String json) => ClusterID(json);

  static ClusterStatus _toStatusFromJson(String json) => switch (json) {
    'NEW' => ClusterStatus.newStatus,
    'ACTIVE' => ClusterStatus.active,
    'IN_PROGRESS' => ClusterStatus.inProgress,
    'ERROR' => ClusterStatus.error,
    _ => ClusterStatus.unknown,
  };
}
