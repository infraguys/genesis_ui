import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_dto.g.dart';

@JsonSerializable(constructor: '_')
class RoleDto implements IDto<Role> {
  factory RoleDto.fromJson(Map<String, dynamic> json) => _$RoleDtoFromJson(json);

  RoleDto._({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.projectId,
  });

  @JsonKey(name: 'uuid', fromJson: _toID)
  final RoleUUID id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'createdAt', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'status', fromJson: _toStatusFromJson)
  final RoleStatus status;
  @JsonKey(name: 'project_id')
  final String projectId;

  @override
  Role toEntity() {
    return Role(
      uuid: id,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      projectId: projectId,
    );
  }

  static RoleUUID _toID(String json) => RoleUUID(json);

  static RoleStatus _toStatusFromJson(String json) => switch (json) {
    'ACTIVE' => RoleStatus.active,
    _ => RoleStatus.unknow,
  };
}
