import 'package:genesis/src/layer_data/requests/create_permission_binding_req.dart';

abstract interface class IPermissionBindingsApi {
  Future<void> createPermissionBinding(CreatePermissionBindingReq req);
}
