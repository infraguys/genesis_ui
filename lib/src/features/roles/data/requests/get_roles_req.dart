import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/features/roles/domain/params/get_roles_params.dart';

final class GetRolesReq implements QueryEncodable, PathEncodable {
  const GetRolesReq(this._params);

  final GetRolesParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {
      'uuid': ?_params.uuids,
    };
  }

  @override
  String toPath() {
    return RolesEndpoints.getRoles();
  }
}
