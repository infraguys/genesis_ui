import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:json_annotation/json_annotation.dart';

part 'database_dto.g.dart';

@JsonSerializable(constructor: '_')
final class DatabaseDto implements IDto<Database> {
  DatabaseDto._({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.projectId,
    required this.instance,
    required this.status,
    required this.owner,
    required this.description,
  });

  factory DatabaseDto.fromJson(Map<String, dynamic> json) => _$DatabaseDtoFromJson(json);

  @JsonKey(name: 'uuid', fromJson: _toID)
  final DatabaseID id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'project_id', fromJson: _toProjectsID)
  final ProjectID projectId;
  @JsonKey(name: 'instance')
  final String instance;
  @JsonKey(name: 'status', fromJson: _toStatusFromJson)
  final DatabaseStatus status;
  @JsonKey(name: 'owner')
  final String owner;
  @JsonKey(name: 'description', defaultValue: '')
  final String? description;

  static DatabaseID _toID(String id) => DatabaseID(id);

  static ProjectID _toProjectsID(String id) => ProjectID(id);

  static DatabaseStatus _toStatusFromJson(String json) => switch (json) {
    'NEW' => DatabaseStatus.newStatus,
    'ACTIVE' => DatabaseStatus.active,
    'IN_PROGRESS' => DatabaseStatus.inProgress,
    'ERROR' => DatabaseStatus.error,
    _ => DatabaseStatus.unknown,
  };

  @override
  Database toEntity() {
    return Database(
      id: id,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
      projectId: projectId,
      instance: instance,
      status: status,
      owner: owner,
      description: description,
    );
  }
}
