import 'package:genesis/src/layer_data/requests/permission_bindings/create_permission_binding_req.dart';
import 'package:genesis/src/layer_data/requests/roles/create_role_req.dart';
import 'package:genesis/src/layer_data/requests/roles/delete_role_req.dart';
import 'package:genesis/src/layer_data/requests/roles/get_roles_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_permission_bindings_api.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_roles_api.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/roles/create_role_params.dart';
import 'package:genesis/src/layer_domain/params/roles/get_roles_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';

final class RolesRepository implements IRolesRepository {
  RolesRepository(this._rolesApi, this._iPermissionBindingsApi);

  final IRolesApi _rolesApi;
  final IPermissionBindingsApi _iPermissionBindingsApi;

  @override
  Future<List<Role>> getRolesByUserUuid(String userUuid) async {
    final rolesDto = await _rolesApi.getRolesByUserUuid(userUuid);
    return rolesDto.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Role> createRole(CreateRoleParams params) async {
    final createRoleReq = CreateRoleReq(params);
    final roleDto = await _rolesApi.createRole(createRoleReq);

    await Future.wait(
      params.permissions.map(
        (it) {
          final createPermReq = CreatePermissionBindingReq(permissionUuid: it.uuid, roleUuid: roleDto.uuid);
          return _iPermissionBindingsApi.createPermissionBinding(createPermReq);
        },
      ),
    );

    return roleDto.toEntity();
  }

  @override
  Future<List<Role>> getRoles(GetRolesParams params) async {
    final req = GetRolesReq(params);
    final rolesDtos = await _rolesApi.getRoles(req);
    return rolesDtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Role> deleteRole(params) async {
    final dto = await _rolesApi.deleteRole(params.toReq());
    return dto.toEntity();
  }
}
