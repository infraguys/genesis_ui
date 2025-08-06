import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/layer_domain/params/change_user_password_params.dart';

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

  /// .../:uuid/actions/change_password/invoke
  @override
  String toPath(String prefix) => '$prefix/${_params.uuid}/actions/change_password/invoke';
}
