import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/database_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/database_params.dart';

final class PgDatabaseReq implements PathEncodable {
  PgDatabaseReq(this._params);

  final DatabaseParams _params;

  @override
  String toPath() {
    return DatabaseEndpoints.item(_params.instanceId, _params.databaseId).fullPath;
  }
}
