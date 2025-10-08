import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/clients_endpoints.dart';
import 'package:genesis/src/layer_domain/params/users/refresh_token_params.dart';

final class RefreshTokenReq implements JsonEncodable, PathEncodable {
  const RefreshTokenReq(this._params);

  final RefreshTokenParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'grant_type': 'refresh_token',
      'client_id': Env.clientId,
      'client_secret': Env.clientSecret,
      'scope': ?_params.scope,
      'ttl': Env.ttl,
      'refresh_ttl': Env.refreshTtl,
      'refresh_token': _params.refreshToken,
    };
  }

  @override
  String toPath() {
    return ClientsEndpoints.getToken();
  }
}
