import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/layer_domain/params/users/change_user_password_params.dart';

class ChangeUserPasswordReq implements JsonEncodable, PathEncodable {
  ChangeUserPasswordReq(this._params);

  final ChangeUserPasswordParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'old_password': _params.oldPassword,
      'new_password': _params.newPassword,
    };
  }

  @override
  String toPath() {
    return UsersEndpoints.changeUserPassword(_params.uuidUUID.value);
  }
}
