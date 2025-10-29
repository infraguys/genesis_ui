import 'package:genesis/src/core/network/endpoints/database_user_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/pg_user_params.dart';

extension PgUserReq on PgUserParams {
  String toPath() {
    return DatabaseUserEndpoints.item(clusterId, pgUserId).fullPath;
  }
}
