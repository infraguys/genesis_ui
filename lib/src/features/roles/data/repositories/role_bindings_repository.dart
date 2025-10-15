import 'package:genesis/src/features/roles/data/requests/create_role_binding_req.dart';
import 'package:genesis/src/features/roles/data/requests/delete_role_binding_req.dart';
import 'package:genesis/src/features/roles/data/requests/get_role_bindings_req.dart';
import 'package:genesis/src/features/roles/data/sources/role_bindings_api.dart';
import 'package:genesis/src/features/roles/domain/entities/role_binding.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';

final class RoleBindingsRepository implements IRoleBindingsRepository {
  RoleBindingsRepository(this._roleBindingsApi);

  final RoleBindingsApi _roleBindingsApi;

  @override
  Future<void> createRoleBinding(params) async {
    await _roleBindingsApi.createRoleBinding(CreateRoleBindingReq(params));
  }

  @override
  Future<void> deleteRoleBinding(uuid) async {
    await _roleBindingsApi.deleteRoleBinding(DeleteRoleBindingReq(uuid));
  }

  @override
  Future<List<RoleBinding>> getRoleBindings(params) async {
    final dtos = await _roleBindingsApi.getRoleBindings(GetRoleBindingsReq(params));
    return dtos.map((it) => it.toEntity()).toList();
  }
}
