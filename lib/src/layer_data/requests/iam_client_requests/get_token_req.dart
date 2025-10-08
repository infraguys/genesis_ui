import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/clients_endpoints.dart';
import 'package:genesis/src/layer_domain/params/get_token_params.dart';

final class GetTokenReq implements JsonEncodable, PathEncodable {
  const GetTokenReq(this._params);

  final GetTokenParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'grant_type': 'password',
      'client_id': Env.clientId,
      'client_secret': Env.clientSecret,
      'scope': ?_params.scope,
      'ttl': Env.ttl,
      'refresh_ttl': Env.refreshTtl,
      'username': _params.username,
      'password': _params.password,
    };
  }

  @override
  String toPath() {
    return ClientsEndpoints.getToken();
  }
}
