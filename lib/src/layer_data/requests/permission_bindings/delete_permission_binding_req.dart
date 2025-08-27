import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';

final class DeletePermissionBindingReq implements PathEncodable {
  DeletePermissionBindingReq(this._uuid);

  final String _uuid;

  @override
  String toPath() {
    return PermissionBindingsEndpoints.deleteRoleBinding(_uuid);
  }
}
