import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission_binding.dart';

final class DeletePermissionBindingReq extends IRequest {
  const DeletePermissionBindingReq(this._id);

  final PermissionBindingID _id;

  @override
  String get path {
    return PermissionBindingsEndpoints.item(_id).fullPath;
  }
}
