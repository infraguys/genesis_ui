import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';

final class GetRoleReq implements PathEncodable {
  const GetRoleReq(this._id);

  final RoleUUID _id;

  @override
  String toPath() => RolesEndpoints.item(_id).fullPath;
}
