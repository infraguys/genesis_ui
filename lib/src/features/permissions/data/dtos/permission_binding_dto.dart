import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission_binding.dart';
import 'package:json_annotation/json_annotation.dart';

part 'permission_binding_dto.g.dart';

@JsonSerializable(constructor: '_')
class PermissionBindingDto implements IDto<PermissionBinding> {
  PermissionBindingDto._({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.roleLink,
    required this.permissionLink,
  });

  factory PermissionBindingDto.fromJson(Map<String, dynamic> json) => _$PermissionBindingDtoFromJson(json);

  @JsonKey(name: 'uuid', fromJson: _toID)
  final PermissionBindingID id;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'role')
  final String roleLink;
  @JsonKey(name: 'permission')
  final String permissionLink;

  static PermissionBindingID _toID(String uuid) => PermissionBindingID(uuid);

  @override
  PermissionBinding toEntity() {
    return PermissionBinding(
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      roleLink: roleLink,
      permissionLink: permissionLink,
    );
  }
}
