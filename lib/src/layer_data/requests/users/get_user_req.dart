import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';

final class GetUserReq implements PathEncodable {
  const GetUserReq(this._uuid);

  final UserUUID _uuid;

  @override
  String toPath() {
    return UsersEndpoints.getUser(_uuid);
  }
}
