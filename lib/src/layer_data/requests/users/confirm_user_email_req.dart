import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/layer_domain/params/users/confirm_user_email_params.dart';

final class ConfirmUserEmailReq implements PathEncodable {
  ConfirmUserEmailReq(this._params);

  final ConfirmUserEmailParams _params;

  @override
  String toPath() => UsersEndpoints.confirmUserEmail(_params.uuid);
}

extension ConfirmUserEmailParamsX on ConfirmUserEmailParams {
  ConfirmUserEmailReq toReq() => ConfirmUserEmailReq(this);
}
