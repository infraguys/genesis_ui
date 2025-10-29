import 'package:genesis/src/core/network/endpoints/database_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/database_user_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/create_database_params.dart';

extension CreatePgDatabaseReq on CreateDatabaseParams {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'owner': DatabaseUserEndpoints.item(instanceId, pgUserId).relativePath,
      'description': ?description,
    };
  }

  String toPath() {
    return DatabaseEndpoints.items(instanceId).fullPath;
  }
}
