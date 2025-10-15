import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/features/roles/domain/params/create_role_params.dart';

final class CreateRoleReq implements JsonEncodable, PathEncodable {
  CreateRoleReq(this._params);

  final CreateRoleParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
    };
  }

  @override
  String toPath() {
    return RolesEndpoints.createRole();
  }
}
