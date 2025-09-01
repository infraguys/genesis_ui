import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';

final class UpdateRoleParams {
  UpdateRoleParams({
    required this.uuid,
    required this.name,
    required this.permissions,
    this.description,
  });

  final RoleUUID uuid;
  final String name;
  final String? description;
  final List<Permission> permissions;
}
