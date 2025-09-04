import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/layer_domain/params/roles/update_role_params.dart';

final class UpdateRoleReq implements JsonEncodable, PathEncodable {
  UpdateRoleReq(this._params);

  final UpdateRoleParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
    };
  }

  @override
  String toPath() {
    return RolesEndpoints.updateRole(_params.uuid.value);
  }
}
