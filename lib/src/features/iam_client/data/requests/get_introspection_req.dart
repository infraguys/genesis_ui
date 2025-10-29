import 'package:genesis/src/core/network/endpoints/clients_endpoints.dart';

final class GetIntrospectionReq {
  const GetIntrospectionReq();

  String toPath() {
    return ClientsEndpoints.introspectIamClient().fullPath;
  }
}
