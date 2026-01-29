import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/features/roles/domain/params/create_role_params.dart';

final class CreateRoleReq extends IRequest {
  const CreateRoleReq(this._params);

  final CreateRoleParams _params;

  @override
  Map<String, dynamic> get body {
    return {
      'name': _params.name,
      'description': ?_params.description,
    };
  }

  @override
  String get path {
    return RolesEndpoints.items().fullPath;
  }
}
