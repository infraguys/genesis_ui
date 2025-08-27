import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';

final class DeleteRoleReq implements PathEncodable {
  DeleteRoleReq(this.uuid);

  final String uuid;

  @override
  String toPath() {
    return RolesEndpoints.deleteRole(uuid);
  }
}
