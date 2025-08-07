import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/create_role_binding_params.dart';

final class CreateRoleBindingReq implements JsonEncodable, PathEncodable {
  CreateRoleBindingReq(this._params);

  final CreateRoleBindingParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'user': '/v1/iam/users/${_params.userUuid}',
      'role': '/v1/iam/roles/${_params.roleUuid}',
      'project': '/v1/iam/projects/${_params.projectUuid}',
    };
  }

  @override
  String toPath(String prefix) {
    return prefix;
  }
}
