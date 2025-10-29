import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/database_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';

final class GetDatabaseUseCase {
  GetDatabaseUseCase(this._repository);

  final IDatabaseRepository _repository;

  Future<Database> call(DatabaseParams params) {
    return _repository.getDatabase(params);
  }
}
