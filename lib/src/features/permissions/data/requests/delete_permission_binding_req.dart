import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission_binding.dart';

final class DeletePermissionBindingReq {
  DeletePermissionBindingReq(this._id);

  final PermissionBindingID _id;

  String toPath() {
    return PermissionBindingsEndpoints.item(_id).fullPath;
  }
}
