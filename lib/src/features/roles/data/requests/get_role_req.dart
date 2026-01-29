import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';

final class GetRoleReq extends IRequest {
  const GetRoleReq(this._id);

  final RoleID _id;

  @override
  String get path {
    return RolesEndpoints.item(_id).fullPath;
  }
}
