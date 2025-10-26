import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/databases_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/database_params.dart';

final class DatabaseReq implements PathEncodable {
  DatabaseReq(this._params);

  final DatabaseParams _params;

  @override
  String toPath() {
    return DatabasesEndpoints.item(_params.instanceId, _params.databaseId).fullPath;
  }
}
