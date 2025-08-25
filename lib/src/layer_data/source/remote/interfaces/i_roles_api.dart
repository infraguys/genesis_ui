import 'package:genesis/src/layer_data/dtos/role_dto.dart';
import 'package:genesis/src/layer_data/requests/roles/create_role_req.dart';
import 'package:genesis/src/layer_data/requests/roles/delete_role_req.dart';
import 'package:genesis/src/layer_data/requests/roles/get_role_req.dart';
import 'package:genesis/src/layer_data/requests/roles/get_roles_req.dart';

abstract interface class IRolesApi {
  Future<List<RoleDto>> getRolesByUserUuid(String userUuid);

  Future<RoleDto> getRole(GetRoleReq req);

  Future<List<RoleDto>> getRoles(GetRolesReq req);

  Future<RoleDto> createRole(CreateRoleReq req);

  Future<void> deleteRole(DeleteRoleReq req);
}
