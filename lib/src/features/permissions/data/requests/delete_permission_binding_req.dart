import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission_binding.dart';

final class DeletePermissionBindingReq implements PathEncodable {
  DeletePermissionBindingReq(this._uuid);

  final PermissionBindingUUID _uuid;

  @override
  String toPath() {
    return PermissionBindingsEndpoints.deletePermissionBinding(_uuid.value);
  }
}
