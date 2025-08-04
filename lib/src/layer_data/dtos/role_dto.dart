import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/entities/status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_dto.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
class RoleDto implements IDto<Role> {
  factory RoleDto.fromJson(Map<String, dynamic> json) => _$RoleDtoFromJson(json);

  RoleDto._({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.projectId,
  });

  final String uuid;
  final String name;
  final String description;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  final RoleStatusDto status;
  final dynamic projectId;

  @override
  Role toEntity() {
    return Role(
      uuid: uuid,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status.toRoleStatus(),
      projectId: projectId,
    );
  }
}

@JsonEnum()
enum RoleStatusDto {
  @JsonValue('ACTIVE')
  active;

  Status toRoleStatus() => switch (this) {
    active => Status.active,
  };
}
