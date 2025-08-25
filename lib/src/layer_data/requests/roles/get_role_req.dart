import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/layer_domain/params/roles/get_role_params.dart';

final class GetRoleReq implements QueryEncodable, PathEncodable {
  const GetRoleReq(this._params);

  final GetRoleParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {};
  }

  @override
  String toPath() {
    return RolesEndpoints.getRole(_params.uuid);
  }
}
