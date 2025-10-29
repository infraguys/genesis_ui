import 'package:genesis/src/core/network/endpoints/database_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/database_params.dart';

extension PgDatabaseReq on DatabaseParams {
  String toPath() {
    return DatabaseEndpoints.item(clusterId, databaseId).fullPath;
  }
}
