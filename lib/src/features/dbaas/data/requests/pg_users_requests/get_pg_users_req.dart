import 'package:genesis/src/core/network/endpoints/database_user_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/get_pg_users_params.dart';

extension GetPgUsersReq on GetPgUsersParams {
  Map<String, dynamic> toQuery() {
    return {};
  }

  String toPath() {
    return DatabaseUserEndpoints.items(clusterId).fullPath;
  }
}
