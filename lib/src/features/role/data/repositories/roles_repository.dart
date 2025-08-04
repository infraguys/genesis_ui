import 'package:genesis/src/features/common/shared_api/i_permission_bindings_api.dart';
import 'package:genesis/src/features/common/shared_entities/role.dart';
import 'package:genesis/src/features/role/data/requests/create_role_req.dart';
import 'package:genesis/src/features/role/data/source/remote/i_roles_api.dart';
import 'package:genesis/src/features/role/domain/params/create_role_params.dart';
import 'package:genesis/src/features/role/domain/repositories/i_roles_repositories.dart';

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
  Future<Role?> createRole(CreateRoleParams params) async {
    final req = CreateRoleReq(params);
    final roleDto = await _rolesApi.createRole(req);

    if (roleDto != null) {
      _iPermissionBindingsApi.createPermissionBinding(
        roleDto.uuid,
        params.permission.uuid,
      );
    }

    return roleDto?.toEntity();
  }
}
