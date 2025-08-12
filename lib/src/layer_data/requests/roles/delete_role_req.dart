import 'package:genesis/src/core/env/endpoints.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/layer_domain/params/roles/delete_role_params.dart';

final class DeleteRoleReq implements PathEncodable {
  DeleteRoleReq(this._params);

  final DeleteRoleParams _params;

  @override
  String toPath() {
    return RolesEndpoints.deleteRole.replaceFirst(':uuid', _params.uuid);
  }
}

extension DeleteRoleParamsX on DeleteRoleParams {
  DeleteRoleReq toReq() => DeleteRoleReq(this);
}
