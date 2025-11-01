import 'package:genesis/src/features/dbaas/domain/entities/db_version.dart';
import 'package:genesis/src/features/dbaas/domain/params/db_versions_params/get_db_versions_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_db_versions_repository.dart';

final class GetDbVersionsUseCase {
  GetDbVersionsUseCase(this._repository);

  final IDBVersionsRepository _repository;

  Future<List<DbVersion>> call(GetDbVersionsParams params) {
    return _repository.getDbVersions(params);
  }
}
