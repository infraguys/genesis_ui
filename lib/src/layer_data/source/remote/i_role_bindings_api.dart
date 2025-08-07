import 'package:genesis/src/layer_data/requests/role_bindings/create_role_binding_req.dart';

abstract interface class IRoleBindingsApi {
  Future<void> createRoleBinding(CreateRoleBindingReq params);
}
