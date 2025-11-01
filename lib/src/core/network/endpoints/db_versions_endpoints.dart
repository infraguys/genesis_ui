import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/dbaas/domain/entities/db_version.dart';

abstract class DbVersionsEndpoints {
  static Endpoint items() {
    return Endpoint.withDbaasPrefix('/types/postgres/versions/');
  }

  static Endpoint item(DbVersionID id) {
    return Endpoint.withDbaasPrefix('/types/postgres/versions/$id');
  }
}