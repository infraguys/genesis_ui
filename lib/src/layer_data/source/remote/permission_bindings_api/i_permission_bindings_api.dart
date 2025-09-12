import 'package:genesis/src/layer_data/dtos/permission_binding_dto.dart';
import 'package:genesis/src/layer_data/requests/permission_binding_requests/create_permission_binding_req.dart';
import 'package:genesis/src/layer_data/requests/permission_binding_requests/delete_permission_binding_req.dart';
import 'package:genesis/src/layer_data/requests/permission_binding_requests/get_permission_bindings_req.dart';

abstract interface class IPermissionBindingsApi {
  Future<PermissionBindingDto> createPermissionBinding(CreatePermissionBindingReq req);

  Future<List<PermissionBindingDto>> getPermissionBindings(GetPermissionBindingsReq req);

  Future<void> deletePermissionBinding(DeletePermissionBindingReq req);
}
