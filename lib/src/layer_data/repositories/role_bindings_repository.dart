import 'package:genesis/src/layer_data/requests/role_bindings/delete_role_binding_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_role_bindings_api.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';

final class RoleBindingsRepository implements IRoleBindingsRepository {
  RoleBindingsRepository(this._roleBindingsApi);

  final IRoleBindingsApi _roleBindingsApi;

  @override
  Future<void> deleteRoleBinding(uuid) async {
    await _roleBindingsApi.deleteRoleBinding(DeleteRoleBindingReq(uuid: uuid));
  }
}
