import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pg_instance_dto.g.dart';

@JsonSerializable(constructor: '_', explicitToJson: true)
class PGInstanceDto implements IDto<PgInstance> {
  PGInstanceDto._({
    required this.id,
    required this.name,
    required this.description,
    required this.projectId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    // required this.ipv4,
    required this.cores,
    required this.ram,
    required this.diskSize,
    required this.nodesNumber,
    required this.syncReplicaNumber,
    required this.version,
  });

  factory PGInstanceDto.fromJson(Map<String, dynamic> json) => _$PGInstanceDtoFromJson(json);

  @JsonKey(name: 'uuid', fromJson: _toID)
  final PgInstanceID id;
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
  @JsonKey(name: 'status', fromJson: _toStatus)
  final PgInstanceStatus status;
  // final List<String> ipv4;
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
  PgInstance toEntity() {
    return PgInstance(
      id: id,
      name: name,
      description: description,
      projectId: projectId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      // ipv4: ipv4,
      cores: cores,
      ram: ram,
      diskSize: diskSize,
      nodesNumber: nodesNumber,
      syncReplicaNumber: syncReplicaNumber,
      version: version,
    );
  }

  static PgInstanceID _toID(String json) => PgInstanceID(json);

  static PgInstanceStatus _toStatus(String json) => switch (json) {
    'NEW' => PgInstanceStatus.newStatus,
    'ACTIVE' => PgInstanceStatus.active,
    'IN_PROGRESS' => PgInstanceStatus.inProgress,
    'ERROR' => PgInstanceStatus.error,
    _ => PgInstanceStatus.unknown,
  };
}
