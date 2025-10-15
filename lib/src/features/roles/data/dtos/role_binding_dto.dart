import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/features/roles/domain/entities/role_binding.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_binding_dto.g.dart';

@JsonSerializable(constructor: '_')
class RoleBindingDto implements IDto<RoleBinding> {
  RoleBindingDto._({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.user,
    required this.role,
    required this.project,
  });

  factory RoleBindingDto.fromJson(Map<String, dynamic> json) => _$RoleBindingDtoFromJson(json);

  @JsonKey(name: 'uuid')
  final String id;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  final String status;
  final String? project;
  final String user;
  final String role;

  @override
  RoleBinding toEntity() {
    return RoleBinding(
      uuid: RoleBindingUUID(id),
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      projectUUID: project != null ? ProjectID(project!.split('/').last) : null,
      userUUID: UserUUID(user.split('/').last),
      roleUUID: RoleUUID(role.split('/').last),
    );
  }
}
