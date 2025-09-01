import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/role_bindings_endpoints.dart';
import 'package:genesis/src/layer_domain/entities/role_binding.dart';

final class DeleteRoleBindingReq implements PathEncodable {
  DeleteRoleBindingReq(this._uuid);

  final RoleBindingUUID _uuid;

  @override
  String toPath() {
    return RoleBindingsEndpoints.deleteRoleBinding(_uuid.value);
  }
}
