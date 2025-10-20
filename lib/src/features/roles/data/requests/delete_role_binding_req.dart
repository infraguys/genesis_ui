import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/role_bindings_endpoints.dart';
import 'package:genesis/src/features/roles/domain/entities/role_binding.dart';

final class DeleteRoleBindingReq implements PathEncodable {
  DeleteRoleBindingReq(this._id);

  final RoleBindingUUID _id;

  @override
  String toPath() => RoleBindingsEndpoints.item(_id).fullPath;
}
