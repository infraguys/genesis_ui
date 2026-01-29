import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/role_bindings_endpoints.dart';
import 'package:genesis/src/features/roles/domain/params/get_role_bindings_params.dart';

final class GetRoleBindingsReq extends IRequest {
  const GetRoleBindingsReq(this._params);

  final GetRoleBindingsParams _params;

  @override
  Map<String, dynamic> get query {
    return {
      'user': ?_params.userUUID,
      'project': ?_params.projectUUID?.raw,
      'role': ?_params.roleUUID?.raw,
      'created_at': ?_params.createdAt?.toIso8601String(),
      'updated_at': ?_params.updatedAt?.toIso8601String(),
    };
  }

  @override
  String get path {
    return RoleBindingsEndpoints.items().fullPath;
  }
}
