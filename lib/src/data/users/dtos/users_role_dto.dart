import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/domain/entities/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users_role_dto.g.dart';

@JsonSerializable(createToJson: false)
class UsersRoleDto implements IDto<Role> {
  UsersRoleDto({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.projectId,
  });

  factory UsersRoleDto.fromJson(Map<String, dynamic> json) => _$UsersRoleDtoFromJson(json);

  final String uuid;
  final String name;
  final String description;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime createdAt;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime updatedAt;
  final UsersRoleStatusDto status;
  final dynamic projectId;

  static DateTime _fromIsoStringToDateTime(String value) => DateTime.parse(value);

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
enum UsersRoleStatusDto {
  @JsonValue('ACTIVE')
  active;

  RoleStatus toRoleStatus() => switch (this) {
    active => RoleStatus.active,
  };
}
