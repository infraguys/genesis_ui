import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/role_bindings_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/features/roles/domain/params/create_role_binding_params.dart';

final class CreateRoleBindingReq extends IRequest {
  const CreateRoleBindingReq(this._params);

  final CreateRoleBindingParams _params;

  @override
  Map<String, dynamic> get body {
    return {
      'user': UsersEndpoints.item(_params.userID).relativePath,
      'role': RolesEndpoints.item(_params.roleID).relativePath,
      'project': ?_params.projectID != null ? ProjectsEndpoints.item(_params.projectID!).relativePath : null,
    };
  }

  @override
  String get path {
    return RoleBindingsEndpoints.items().fullPath;
  }
}
