import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/role_binding.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_binding_dto.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
class RoleBindingDto implements IDto<RoleBinding> {
  RoleBindingDto._({
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.user,
    required this.role,
    required this.project,
  });

  factory RoleBindingDto.fromJson(Map<String, dynamic> json) => _$RoleBindingDtoFromJson(json);

  final String uuid;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  final String status;
  final String? project;
  final String user;
  final String role;

  @override
  RoleBinding toEntity() {
    return RoleBinding(
      uuid: uuid,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      projectUUID: project?.split('/').last,
      userUUID: user.split('/').last,
      roleUUID: role.split('/').last,
    );
  }
}
