import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/role_bindings_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/features/roles/domain/params/create_role_binding_params.dart';

final class CreateRoleBindingReq implements JsonEncodable, PathEncodable {
  CreateRoleBindingReq(this._params);

  final CreateRoleBindingParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'user': UsersEndpoints.getUser(_params.userUUID).replaceFirst('${Env.apiPrefix}/', ''),
      'role': RolesEndpoints.getRole(_params.roleUUID).replaceFirst('${Env.apiPrefix}/', ''),
      'project': ?_params.projectUUID != null
          ? ProjectsEndpoints.getProject(_params.projectUUID!).replaceFirst('${Env.apiPrefix}/', '')
          : null,
    };
  }

  @override
  String toPath() {
    return RoleBindingsEndpoints.createRoleBinding();
  }
}
