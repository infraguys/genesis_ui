import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';

final class GetRoleReq implements PathEncodable {
  const GetRoleReq(this._uuid);

  final RoleUUID _uuid;

  @override
  String toPath() {
    return RolesEndpoints.getRole(_uuid);
  }
}
