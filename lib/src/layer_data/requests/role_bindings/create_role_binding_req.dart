import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/role_bindings_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/create_role_binding_params.dart';

final class CreateRoleBindingReq implements JsonEncodable, PathEncodable {
  CreateRoleBindingReq(this._params);

  final CreateRoleBindingParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'user': UsersEndpoints.getUser(_params.userUUID),
      'role': RolesEndpoints.getRole(_params.roleUUID),
      'project': ?_params.projectUUID != null ? ProjectsEndpoints.getProject(_params.projectUUID!) : null,
    };
  }

  @override
  String toPath() {
    return RoleBindingsEndpoints.createRoleBinding();
  }
}
