import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/role_bindings_endpoints.dart';
import 'package:genesis/src/features/roles/domain/entities/role_binding.dart';

final class DeleteRoleBindingReq extends IRequest {
  const DeleteRoleBindingReq(this._id);

  final RoleBindingID _id;

  @override
  String get path {
    return RoleBindingsEndpoints.item(_id).fullPath;
  }
}
