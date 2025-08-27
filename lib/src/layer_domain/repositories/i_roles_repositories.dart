import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/roles/create_role_params.dart';
import 'package:genesis/src/layer_domain/params/roles/delete_role_params.dart';
import 'package:genesis/src/layer_domain/params/roles/get_role_params.dart';
import 'package:genesis/src/layer_domain/params/roles/get_roles_params.dart';

abstract interface class IRolesRepository {
  Future<List<Role>> getRolesByUserUuid(String userUuid);

  Future<List<Role>> getRoles(GetRolesParams params);

  Future<Role> getRole(GetRoleParams params);

  Future<Role> createRole(CreateRoleParams params);

  Future<void> deleteRole(DeleteRoleParams params);
}
