import 'package:genesis/src/core/network/endpoints/database_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/update_database_params.dart';

extension UpdateDatabaseReq on UpdateDatabaseParams {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      // 'owner': _params.owner,
      'description': ?description,
    };
  }

  String toPath() {
    return DatabaseEndpoints.item(clusterId, databaseId).fullPath;
  }
}
