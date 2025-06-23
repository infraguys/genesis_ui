class CreateTokenParams {
  CreateTokenParams({
    required this.iamClientUuid,
    required this.grantType,
    required this.clientId,
    required this.clientSecret,
    required this.username,
    required this.password,
    this.scope,
    this.ttl,
    this.refreshTtl,
  });

  final String iamClientUuid;
  final String grantType;
  final String clientId;
  final String clientSecret;
  final String username;
  final String password;
  final String? scope;
  final int? ttl;
  final int? refreshTtl;
}
