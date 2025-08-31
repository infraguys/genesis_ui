import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';

final class DeleteUserReq implements PathEncodable {
  DeleteUserReq(this._uuid);

  final String _uuid;

  @override
  String toPath() {
    return UsersEndpoints.deleteUser(_uuid);
  }
}
