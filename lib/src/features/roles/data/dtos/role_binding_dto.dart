import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/roles/domain/entities/role_binding.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_binding_dto.g.dart';

@JsonSerializable(constructor: '_')
class RoleBindingDto implements IDto<RoleBinding> {
  RoleBindingDto._({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.userLink,
    required this.roleLink,
    required this.projectLink,
  });

  factory RoleBindingDto.fromJson(Map<String, dynamic> json) => _$RoleBindingDtoFromJson(json);

  @JsonKey(name: 'uuid', fromJson: _toID)
  final RoleBindingUUID id;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'project')
  final String? projectLink;
  @JsonKey(name: 'user')
  final String userLink;
  @JsonKey(name: 'role')
  final String roleLink;

  static RoleBindingUUID _toID(String id) => RoleBindingUUID(id);

  @override
  RoleBinding toEntity() {
    return RoleBinding(
      uuid: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      projectLink: projectLink,
      userLink: userLink,
      roleLink: roleLink,
    );
  }
}
