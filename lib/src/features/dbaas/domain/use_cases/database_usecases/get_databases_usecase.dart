import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/get_databases_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';

final class GetDatabasesUseCase {
  GetDatabasesUseCase(this._repository);

  final IDatabaseRepository _repository;

  Future<List<Database>> call(GetDatabasesParams params) {
    return _repository.getDatabases(params);
  }
}