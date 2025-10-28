import 'package:genesis/src/core/network/endpoints/database_user_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_users/create_pg_user_params.dart';

extension CreatePgUserReq on CreatePgUserParams {
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': password,
      'description': ?description,
    };
  }

  String toPath() {
    return DatabaseUserEndpoints.items(pgInstanceId).fullPath;
  }
}
