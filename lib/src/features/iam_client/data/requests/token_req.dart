import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/clients_endpoints.dart';
import 'package:genesis/src/features/iam_client/domain/params/get_token_params.dart';
import 'package:genesis/src/features/iam_client/domain/params/refresh_token_params.dart';

abstract base class TokenReq implements JsonEncodable, PathEncodable {
  const TokenReq();

  @override
  Map<String, dynamic> toJson();

  @override
  String toPath() {
    return ClientsEndpoints.getToken();
  }
}

final class GetTokenReq extends TokenReq {
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
      // 'refresh_ttl': Env.refreshTtl,
      'username': _params.username,
      'password': _params.password,
    };
  }
}

final class RefreshTokenReq extends TokenReq {
  const RefreshTokenReq(this._params);

  final RefreshTokenParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'grant_type': 'refresh_token',
      'client_id': Env.clientId,
      'client_secret': Env.clientSecret,
      'scope': ?_params.scope != null ? 'project:${_params.scope}' : null,
      'ttl': Env.ttl,
      // 'refresh_ttl': Env.refreshTtl,
      'refresh_token': _params.refreshToken,
    };
  }
}
