import 'package:genesis/src/layer_data/dtos/role_binding_dto.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/create_role_binding_req.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/delete_role_binding_req.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/get_role_bindings_req.dart';

abstract interface class IRoleBindingsApi {
  Future<void> createRoleBinding(CreateRoleBindingReq req);

  Future<List<RoleBindingDto>> getRoleBindings(GetRoleBindingsReq req);

  Future<void> deleteRoleBinding(DeleteRoleBindingReq req);
}
