import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pg_instance_dto.g.dart';

@JsonSerializable(constructor: '_')
class PGInstanceDto implements IDto<PGInstance> {
  PGInstanceDto._({
    required this.uuid,
    required this.name,
    required this.description,
    required this.projectId,
    required this.status,
    required this.ipsv4,
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
  final PGInstanceStatusDto status;
  final List<String> ipsv4;
  final int cpu;
  final int ram;
  final int diskSize;
  final int nodesNumber;
  final int syncReplicaNumber;
  final String version;

  @override
  PGInstance toEntity() {
    return PGInstance(
      uuid: PGInstanceUUID(uuid),
      name: name,
      description: description,
      projectId: projectId,
      status: status.toPGInstanceStatus(),
      ipsv4: ipsv4,
      cpu: cpu,
      ram: ram,
      diskSize: diskSize,
      nodesNumber: nodesNumber,
      syncReplicaNumber: syncReplicaNumber,
      version: version,
    );
  }
}

@JsonEnum()
enum PGInstanceStatusDto {
  @JsonValue('NEW')
  newStatus,
  @JsonValue('ACTIVE')
  active,
  @JsonValue('IN_PROGRESS')
  inProgress,
  @JsonValue('ERROR')
  error;

  PGInstanceStatus toPGInstanceStatus() => switch (this) {
    newStatus => PGInstanceStatus.newStatus,
    active => PGInstanceStatus.active,
    inProgress => PGInstanceStatus.inProgress,
    error => PGInstanceStatus.error,
  };
}
