import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';

final class ForceConfirmEmailReq implements PathEncodable {
  ForceConfirmEmailReq(this._uuid);

  final UserUUID _uuid;

  @override
  String toPath() {
    return UsersEndpoints.forceConfirmUserEmail(_uuid.value);
  }
}
