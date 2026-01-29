import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/roles/data/json_converters/role_id_converter.dart';
import 'package:genesis/src/features/roles/data/json_converters/role_status_converter.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_dto.g.dart';

@JsonSerializable(constructor: '_')
class RoleDto implements IDto<Role> {
  RoleDto._({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.projectId,
  });

  factory RoleDto.fromJson(Map<String, dynamic> json) => _$RoleDtoFromJson(json);

  @RoleIdConverter()
  @JsonKey(name: 'uuid')
  final RoleID id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @RoleStatusConverter()
  @JsonKey(name: 'status')
  final RoleStatus status;
  @JsonKey(name: 'project_id')
  final String? projectId;

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
}
