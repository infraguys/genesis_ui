import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pg_instance_dto.g.dart';

@JsonSerializable(constructor: '_')
class PGInstanceDto implements IDto<PgInstance> {
  PGInstanceDto._({
    required this.uuid,
    required this.name,
    required this.description,
    required this.projectId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.ipv4,
    required this.cpu,
    required this.ram,
    required this.diskSize,
    required this.nodesNumber,
    required this.syncReplicaNumber,
    required this.version,
  });

  factory PGInstanceDto.fromJson(Map<String, dynamic> json) => _$PGInstanceDtoFromJson(json);

  final String uuid;
  final String name;
  @JsonKey(defaultValue: '')
  final String description;
  final String projectId;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(fromJson: _statusFromJson)
  final PgInstanceStatus status;
  final List<String> ipv4;
  final int cpu;
  final int ram;
  final int diskSize;
  final int nodesNumber;
  final int syncReplicaNumber;
  final String version;

  @override
  PgInstance toEntity() {
    return PgInstance(
      uuid: PGInstanceUUID(uuid),
      name: name,
      description: description,
      projectId: projectId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      ipv4: ipv4,
      cpu: cpu,
      ram: ram,
      diskSize: diskSize,
      nodesNumber: nodesNumber,
      syncReplicaNumber: syncReplicaNumber,
      version: version,
    );
  }

  static PgInstanceStatus _statusFromJson(String json) => switch (json) {
    'NEW' => PgInstanceStatus.newStatus,
    'ACTIVE' => PgInstanceStatus.active,
    'IN_PROGRESS' => PgInstanceStatus.inProgress,
    'ERROR' => PgInstanceStatus.error,
    _ => PgInstanceStatus.unknown,
  };
}
