import 'package:genesis/src/features/dbaas/data/source/remote/db_versions_api.dart';
import 'package:genesis/src/features/dbaas/domain/entities/db_version.dart';
import 'package:genesis/src/features/dbaas/domain/params/db_versions_params/get_db_versions_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_db_versions_repository.dart';

final class DbVersionsRepository implements IDBVersionsRepository {
  DbVersionsRepository(this._api);

  final DbVersionsApi _api;

  @override
  Future<List<DbVersion>> getDbVersions(GetDbVersionsParams params) async {
    final dtos = await _api.getDbVersions(params);
    return dtos.map((dto) => dto.toEntity()).toList();
  }
}
