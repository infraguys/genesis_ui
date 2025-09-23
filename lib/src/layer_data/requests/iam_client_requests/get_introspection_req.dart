import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/clients_endpoints.dart';

final class GetIntrospectionReq implements PathEncodable {
  const GetIntrospectionReq();

  @override
  String toPath() {
    return ClientsEndpoints.introspectIamClient();
  }
}
