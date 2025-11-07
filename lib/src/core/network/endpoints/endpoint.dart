import 'package:genesis/src/core/env/env.dart';

final class Endpoint {
  Endpoint({required String path, required String apiPrefix}) : _apiPrefix = apiPrefix, _path = path;

  Endpoint.withCorePrefix(String path)
    : this(
        apiPrefix: Env.apiPrefix,
        path: path,
      );

  Endpoint.withDbaasPrefix(String path)
    : this(
        apiPrefix: Env.dbaasApiPrefix,
        path: path,
      );

  final String _path;
  final String _apiPrefix;

  String get relativePath => '/${Env.versionApi}$_path';

  String get fullPath => '${Env.baseUrl}$_apiPrefix$relativePath';
}
