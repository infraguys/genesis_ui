import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/layer_domain/params/roles/delete_role_params.dart';

final class DeleteRoleReq implements PathEncodable {
  DeleteRoleReq(this._params);

  final DeleteRoleParams _params;

  @override
  String toPath() {
    return RolesEndpoints.deleteRole(_params.uuid);
  }
}

extension DeleteRoleParamsX on DeleteRoleParams {
  DeleteRoleReq toReq() => DeleteRoleReq(this);
}
