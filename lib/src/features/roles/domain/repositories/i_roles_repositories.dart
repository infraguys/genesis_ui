import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/features/roles/domain/params/create_role_params.dart';
import 'package:genesis/src/features/roles/domain/params/get_roles_params.dart';
import 'package:genesis/src/features/roles/domain/params/update_role_params.dart';

abstract interface class IRolesRepository {
  Future<List<Role>> getRolesByUserUuid(String userUuid);

  Future<List<Role>> getRoles(GetRolesParams params);

  Future<Role> getRole(RoleUUID uuid);

  Future<Role> createRole(CreateRoleParams params);

  Future<void> deleteRole(RoleUUID uuid);

  Future<Role> updateRole(UpdateRoleParams params);
}
