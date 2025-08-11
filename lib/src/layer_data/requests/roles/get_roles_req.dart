import 'package:genesis/src/core/env/endpoints.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/layer_domain/params/roles/get_roles_params.dart';

final class GetRolesReq implements QueryEncodable, PathEncodable {
  const GetRolesReq(this._params);

  final GetRolesParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {};
  }

  @override
  String toPath() {
    return RolesEndpoints.getRoles;
  }
}
