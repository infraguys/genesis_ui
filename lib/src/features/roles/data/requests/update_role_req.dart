import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/features/roles/domain/params/update_role_params.dart';

final class UpdateRoleReq extends IRequest {
  const UpdateRoleReq(this._params);

  final UpdateRoleParams _params;

  @override
  Map<String, dynamic> get body {
    return {
      'name': _params.name,
      'description': ?_params.description,
    };
  }

  @override
  String get path {
    return RolesEndpoints.item(_params.id).fullPath;
  }
}
