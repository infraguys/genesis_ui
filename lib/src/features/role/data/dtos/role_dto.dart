import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/common/shared_entities/role.dart';
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
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime createdAt;
  @JsonKey(fromJson: _fromIsoStringToDateTime)
  final DateTime updatedAt;
  final RoleStatusDto status;
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
enum RoleStatusDto {
  @JsonValue('ACTIVE')
  active;

  RoleStatus toRoleStatus() => switch (this) {
    active => RoleStatus.active,
  };
}
