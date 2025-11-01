import 'package:genesis/src/features/dbaas/domain/entities/db_version.dart';
import 'package:genesis/src/features/dbaas/domain/params/db_versions_params/get_db_versions_params.dart';

abstract interface class IDBVersionsRepository {
  Future<List<DbVersion>> getDbVersions(GetDbVersionsParams params);
}
