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

  String? get _projectRelativePath {
    if (_params.projectUUID == null) {
      return null;
    }
    return ProjectsEndpoints.item(_params.projectUUID!).relativePath;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'user': UsersEndpoints.item(_params.userUUID).relativePath,
      'role': RolesEndpoints.item(_params.roleUUID).relativePath,
      'project': ?_projectRelativePath,
    };
  }

  @override
  String toPath() => RoleBindingsEndpoints.items().fullPath;
}
