import 'package:genesis/src/layer_data/requests/roles/create_role_req.dart';
import 'package:genesis/src/layer_data/requests/roles/delete_role_req.dart';
import 'package:genesis/src/layer_data/requests/roles/get_role_req.dart';
import 'package:genesis/src/layer_data/requests/roles/get_roles_req.dart';
import 'package:genesis/src/layer_data/requests/roles/update_role_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_roles_api.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';

final class RolesRepository implements IRolesRepository {
  RolesRepository(this._rolesApi);

  final IRolesApi _rolesApi;

  @override
  Future<List<Role>> getRolesByUserUuid(userUuid) async {
    final rolesDto = await _rolesApi.getRolesByUserUuid(userUuid);
    return rolesDto.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Role> getRole(params) async {
    final roleDto = await _rolesApi.getRole(GetRoleReq(params));
    return roleDto.toEntity();
  }

  @override
  Future<Role> createRole(params) async {
    final createRoleReq = CreateRoleReq(params);
    final roleDto = await _rolesApi.createRole(createRoleReq);
    return roleDto.toEntity();
  }

  @override
  Future<List<Role>> getRoles(params) async {
    final req = GetRolesReq(params);
    final rolesDtos = await _rolesApi.getRoles(req);
    return rolesDtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<void> deleteRole(uuid) async {
    await _rolesApi.deleteRole(DeleteRoleReq(uuid));
  }

  @override
  Future<Role> updateRole(params) async {
    final dto = await _rolesApi.updateRole(UpdateRoleReq(params));
    return dto.toEntity();
  }
}
