import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/role_bindings_endpoints.dart';

final class DeleteRoleBindingReq implements PathEncodable {
  DeleteRoleBindingReq({
    required this.uuid,
  });

  final String uuid;

  @override
  String toPath() {
    return RoleBindingsEndpoints.deleteRoleBinding(uuid);
  }
}
