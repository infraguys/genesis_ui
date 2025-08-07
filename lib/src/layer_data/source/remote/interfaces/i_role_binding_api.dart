import 'package:genesis/src/layer_data/dtos/roles_bindings.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/create_role_binding_req.dart';

abstract interface class IRoleBindingApi {
  Future<RolesBindingDto> createRoleBinding(CreateRoleBindingReq req);
}
