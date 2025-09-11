import 'package:genesis/src/core/extensions/nullable_extension.dart';
import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/projects_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/role_bindings_endpoints.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/create_role_binding_params.dart';

final class CreateRoleBindingReq implements JsonEncodable, PathEncodable {
  CreateRoleBindingReq(this._params);

  final CreateRoleBindingParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'user': '/v1/iam/users/${_params.userUUID}',
      'role': '/v1/iam/roles/${_params.roleUUID.value}',
      'project': ?_params.projectUUID.notNull((it) => '/v1${ProjectsEndpoints.getProject(it.value)}'),
    };
  }

  @override
  String toPath() {
    return RoleBindingsEndpoints.createRoleBinding();
  }
}
