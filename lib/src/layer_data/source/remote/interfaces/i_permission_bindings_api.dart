import 'package:genesis/src/layer_data/dtos/permission_dto.dart';
import 'package:genesis/src/layer_data/requests/create_permission_binding_req.dart';

abstract interface class IPermissionBindingsApi {
  Future<PermissionDto> createPermissionBinding(CreatePermissionBindingReq req);
}
