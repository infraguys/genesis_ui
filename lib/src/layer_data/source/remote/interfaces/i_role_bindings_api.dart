import 'package:genesis/src/layer_data/dtos/roles_bindings.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/create_role_binding_req.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/get_role_bindings_req.dart';

abstract interface class IRoleBindingsApi {
  Future<void> createRoleBinding(CreateRoleBindingReq req);

  Future<List<RolesBindingDto>> getRoleBindings(GetRoleBindingsReq req);
}
