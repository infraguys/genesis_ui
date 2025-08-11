import 'package:genesis/src/core/env/endpoints.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/layer_domain/params/users/delete_user_params.dart';

final class DeleteUserReq implements PathEncodable {
  DeleteUserReq(this._params);

  final DeleteUserParams _params;

  @override
  String toPath() {
    return UsersEndpoints.deleteUser.replaceFirst(':uuid', _params.uuid);
  }
}
