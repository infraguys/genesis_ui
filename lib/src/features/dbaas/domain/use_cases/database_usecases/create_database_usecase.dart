import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/params/databases/create_database_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';

final class CreateDatabaseUseCase {
  CreateDatabaseUseCase(this._repository);

  final IDatabaseRepository _repository;

  Future<Database> call(CreateDatabaseParams params) {
    return _repository.createDatabase(params);
  }
}
