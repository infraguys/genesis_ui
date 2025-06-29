abstract class Env {
  static const apiUrl = String.fromEnvironment('api_url');

  // Iam client config
  static const iamClientUuid = String.fromEnvironment('iam_client_uuid');
  static const clientId = String.fromEnvironment('client_id');
  static const clientSecret = String.fromEnvironment('client_secret');
  static const grantType = String.fromEnvironment('grant_type');
  static const ttl = int.fromEnvironment('ttl');
  static const refreshTtl = int.fromEnvironment('refresh_ttl');
  static const scope = String.fromEnvironment('scope');
}
