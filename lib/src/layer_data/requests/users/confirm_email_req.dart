import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/layer_domain/params/users/confirm_email_params.dart';

final class ConfirmEmailReq implements PathEncodable {
  ConfirmEmailReq(this._params);

  final ConfirmEmailParams _params;

  @override
  String toPath() => UsersEndpoints.confirmUserEmail(_params.uuid);
}

extension ConfirmEmailParamsX on ConfirmEmailParams {
  ConfirmEmailReq toReq() => ConfirmEmailReq(this);
}
