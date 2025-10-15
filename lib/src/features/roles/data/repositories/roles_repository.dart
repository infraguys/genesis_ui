import 'package:genesis/src/features/roles/data/requests/create_role_req.dart';
import 'package:genesis/src/features/roles/data/requests/delete_role_req.dart';
import 'package:genesis/src/features/roles/data/requests/get_role_req.dart';
import 'package:genesis/src/features/roles/data/requests/get_roles_req.dart';
import 'package:genesis/src/features/roles/data/requests/update_role_req.dart';
import 'package:genesis/src/features/roles/data/sources/roles_api.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';

final class RolesRepository implements IRolesRepository {
  RolesRepository(this._rolesApi);

  final RolesApi _rolesApi;

  @override
  Future<List<Role>> getRolesByUserUuid(userUuid) async {
    final rolesDto = await _rolesApi.getRolesByUserUuid(userUuid);
    return rolesDto.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Role> getRole(uuid) async {
    final roleDto = await _rolesApi.getRole(GetRoleReq(uuid));
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
    final rolesDtos = await _rolesApi.getRoles(GetRolesReq(params));
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
