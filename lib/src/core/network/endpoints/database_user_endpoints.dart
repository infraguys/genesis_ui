import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';

abstract class DbUserEndpoints {
  static Endpoint items(PgInstanceID pgInstanceId) {
    return Endpoint.withDbaasPrefix('/types/postgres/instances/$pgInstanceId/users/');
  }

  static Endpoint item(PgInstanceID pgInstanceId, PgUserID pgUserId) {
    return Endpoint.withDbaasPrefix('/types/postgres/instances/$pgInstanceId/users/$pgUserId');
  }
}
