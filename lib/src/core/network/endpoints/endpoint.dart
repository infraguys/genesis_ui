import 'package:genesis/src/core/env/env.dart';

final class Endpoint {
  Endpoint._({
    required String path,
    required String apiPrefix,
  }) : _apiPrefix = apiPrefix,
       _path = path;

  Endpoint.withCorePrefix(String path)
    : this._(
        apiPrefix: Env.apiPrefix,
        path: path,
      );

  Endpoint.withDbaasPrefix(String path)
    : this._(
        apiPrefix: Env.dbaasApiPrefix,
        path: path,
      );

  final String _path;
  final String _apiPrefix;

  String get relativePath => '/${Env.versionApi}$_path';

  String get fullPath => '${Env.baseUrl}$_apiPrefix$relativePath';
}
