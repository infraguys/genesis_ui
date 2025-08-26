import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/layer_domain/params/users/confirm_email_params.dart';

final class ForceConfirmEmailReq implements PathEncodable {
  ForceConfirmEmailReq(this._params);

  final ConfirmEmailParams _params;

  @override
  String toPath() {
    return UsersEndpoints.forceConfirmUserEmail(_params.uuid);
  }
}
