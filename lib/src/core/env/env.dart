abstract class Env {
  static const _envString = String.fromEnvironment('env');

  // Iam client config

  static const versionApi = String.fromEnvironment('version_api', defaultValue: 'v1');
  static const iamClientUuid = String.fromEnvironment('iam_client_uuid');
  static const clientId = String.fromEnvironment('client_id');
  static const clientSecret = String.fromEnvironment('client_secret');
  static const grantType = String.fromEnvironment('grant_type');
  static const ttl = int.fromEnvironment('ttl');
  static const refreshTtl = int.fromEnvironment('refresh_ttl');
  static const scope = String.fromEnvironment('scope');

  static const apiPrefix = '/api';
  static const dbaasApiPrefix = '/dbaas-api';

  static EnvMode mode = switch (_envString) {
    'stage' => EnvMode.stage,
    'prod' => EnvMode.prod,
    _ => EnvMode.dev,
  };
}

enum EnvMode {
  dev,
  stage,
  prod;

  bool get isDev => this == EnvMode.dev;

  bool get isProd => this == EnvMode.prod;

  bool get isStage => this == EnvMode.stage;
}
