import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission_binding.dart';

final class DeletePermissionBindingReq implements PathEncodable {
  DeletePermissionBindingReq(this._id);

  final PermissionBindingID _id;

  @override
  String toPath() {
    return PermissionBindingsEndpoints.deletePermissionBinding(_id.value);
  }
}
