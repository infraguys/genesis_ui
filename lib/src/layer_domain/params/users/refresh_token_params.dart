final class RefreshTokenParams {
  RefreshTokenParams({
    required this.refreshToken,
    required this.scope,
  });

  final String refreshToken;
  final String? scope;
}
