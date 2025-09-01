import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/permission_binding.dart';
import 'package:json_annotation/json_annotation.dart';

part 'permission_binding_dto.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
class PermissionBindingDto implements IDto<PermissionBinding> {
  PermissionBindingDto._({
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.permission,
  });

  factory PermissionBindingDto.fromJson(Map<String, dynamic> json) => _$PermissionBindingDtoFromJson(json);

  final String uuid;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  final String role;
  final String permission;

  @override
  PermissionBinding toEntity() {
    return PermissionBinding(
      uuid: uuid,
      createdAt: createdAt,
      updatedAt: updatedAt,
      roleUUID: role.split('/').last,
      permissionUUID: permission.split('/').last,
    );
  }
}
