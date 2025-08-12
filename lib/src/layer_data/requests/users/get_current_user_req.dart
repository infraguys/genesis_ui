import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/clients_endpoints.dart';

final class GetCurrentUserReq implements PathEncodable {
  const GetCurrentUserReq();

  @override
  String toPath() {
    return ClientsEndpoints.getMe;
  }
}
