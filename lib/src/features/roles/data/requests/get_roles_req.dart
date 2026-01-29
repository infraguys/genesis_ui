import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/features/roles/domain/params/get_roles_params.dart';

final class GetRolesReq extends IRequest {
  const GetRolesReq(this._params);

  final GetRolesParams _params;

  @override
  Map<String, dynamic> get query {
    return {
      'uuid': ?_params.uuids,
    };
  }

  @override
  String get path {
    return RolesEndpoints.items().fullPath;
  }
}
