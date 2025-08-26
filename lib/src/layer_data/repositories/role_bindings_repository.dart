import 'package:genesis/src/layer_data/requests/role_bindings/create_role_binding_req.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/delete_role_binding_req.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/get_role_bindings_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_role_bindings_api.dart';
import 'package:genesis/src/layer_domain/entities/role_binding.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';

final class RoleBindingsRepository implements IRoleBindingsRepository {
  RoleBindingsRepository(this._roleBindingsApi);

  final IRoleBindingsApi _roleBindingsApi;

  @override
  Future<void> createRoleBinding(params) async {
    await _roleBindingsApi.createRoleBinding(CreateRoleBindingReq(params));
  }

  @override
  Future<void> deleteRoleBinding(uuid) async {
    await _roleBindingsApi.deleteRoleBinding(DeleteRoleBindingReq(uuid: uuid));
  }

  @override
  Future<List<RoleBinding>> getRoleBindings(params) async {
    final dtos = await _roleBindingsApi.getRoleBindings(GetRoleBindingsReq(params));
    return dtos.map((it) => it.toEntity()).toList();
  }
}
