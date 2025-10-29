import 'package:genesis/src/core/network/endpoints/database_user_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/update_pg_user_params.dart';

extension UpdatePgUserReq on UpdatePgUserParams {
  Map<String, dynamic> toJson() {
    return {
      'description': ?description,
      'password': ?password,
    };
  }

  String toPath() {
    return DatabaseUserEndpoints.item(pgInstanceId, pgUserId).fullPath;
  }
}
