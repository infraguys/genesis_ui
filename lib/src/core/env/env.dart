abstract class Env {
  static final _envString = String.fromEnvironment('env', defaultValue: EnvMode.unknown.name);

  static const apiUrl = String.fromEnvironment('api_url');

  // Iam client config
  static const iamClientUuid = String.fromEnvironment('iam_client_uuid');
  static const clientId = String.fromEnvironment('client_id');
  static const clientSecret = String.fromEnvironment('client_secret');
  static const grantType = String.fromEnvironment('grant_type');
  static const ttl = int.fromEnvironment('ttl');
  static const refreshTtl = int.fromEnvironment('refresh_ttl');
  static const scope = String.fromEnvironment('scope');

  static EnvMode mode = switch (_envString) {
    'dev' => EnvMode.dev,
    'stage' => EnvMode.stage,
    'prod' => EnvMode.prod,
    _ => EnvMode.unknown,
  };
}

enum EnvMode {
  dev,
  stage,
  prod,
  unknown;

  bool get isDev => this == EnvMode.dev;

  bool get isProd => this == EnvMode.prod;

  bool get isStage => this == EnvMode.stage;
}
