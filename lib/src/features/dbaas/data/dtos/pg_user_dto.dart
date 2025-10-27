import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pg_user_dto.g.dart';

@JsonSerializable(constructor: '_', explicitToJson: true)
final class PgUserDto {
  PgUserDto._({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.projectId,
    required this.instance,
    required this.status,
    required this.password,
    required this.passwordHash,
  });

  @JsonKey(name: 'uuid', fromJson: _toID)
  final PgUserID id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'project_id', fromJson: _toProjectID)
  final ProjectID projectId;
  @JsonKey(name: 'instance')
  final String instance;
  @JsonKey(name: 'status', fromJson: _toStatusFromJson)
  final PgUserStatus status;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'password_hash')
  final String passwordHash;

  static PgUserID _toID(String id) => PgUserID(id);

  static ProjectID _toProjectID(String id) => ProjectID(id);

  static PgUserStatus _toStatusFromJson(String json) => switch (json) {
    'NEW' => PgUserStatus.newStatus,
    'ACTIVE' => PgUserStatus.active,
    'IN_PROGRESS' => PgUserStatus.inProgress,
    'ERROR' => PgUserStatus.error,
    _ => PgUserStatus.unknown,
  };
}
