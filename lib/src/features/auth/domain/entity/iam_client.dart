class IamClient {
  IamClient({
    required this.accessToken,
    required this.expiresAt,
    required this.idToken,
    required this.refreshToken,
    required this.scope,
    required this.tokenType,
  });

  final String accessToken;
  final int expiresAt;
  final String idToken;
  final String refreshToken;
  final String scope;
  final String tokenType;
}

/**
 *  "access_token": "eyJhbGciOiJSUzI...",
    "expires_at": 1740524674,
    "id_token": "eyJhbGciOiJSUzI1NiIsInR...",
    "refresh_token": "eyJhbGciOiJIUzUxMiIsIn...",
    "scope": "openid email profile",
    "token_type": "Bearer"
    }
 *
 *
 *
 *
 */
