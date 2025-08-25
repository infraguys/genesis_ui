import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/layer_domain/params/users/get_user_params.dart';

final class GetUserReq implements PathEncodable {
  const GetUserReq(this._params);

  final GetUserParams _params;

  @override
  String toPath() {
    return UsersEndpoints.getUser(_params.uuid);
  }
}
