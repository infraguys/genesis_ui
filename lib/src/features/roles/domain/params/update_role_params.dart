import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';

final class UpdateRoleParams {
  UpdateRoleParams({
    required this.id,
    required this.name,
    required this.permissions,
    this.description,
  });

  final RoleUUID id;
  final String name;
  final String? description;
  final List<Permission> permissions;
}
