import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';

final class ConfirmEmailReq implements PathEncodable {
  ConfirmEmailReq(this._uuid);

  final UserUUID _uuid;

  @override
  String toPath() {
    return UsersEndpoints.confirmUserEmail(_uuid);
  }
}
