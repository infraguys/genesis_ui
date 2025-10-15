import 'package:genesis/src/features/roles/domain/entities/role.dart';

final class GetPermissionBindingsParams {
  const GetPermissionBindingsParams({
    this.permission,
    this.roleUUID,
    this.createdAt,
    this.updatedAt,
  });

  final String? permission;
  final RoleUUID? roleUUID;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
