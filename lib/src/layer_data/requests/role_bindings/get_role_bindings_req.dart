import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/core/network/endpoints/role_bindings_endpoints.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/get_role_bindings_params.dart';

final class GetRoleBindingsReq implements QueryEncodable, PathEncodable {
  GetRoleBindingsReq(this._params);

  final GetRoleBindingsParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {
      'user': ?_params.userUuid,
      'project': ?_params.projectUuid,
    };
  }

  @override
  String toPath() {
    return RoleBindingsEndpoints.getRoleBindings;
  }
}
