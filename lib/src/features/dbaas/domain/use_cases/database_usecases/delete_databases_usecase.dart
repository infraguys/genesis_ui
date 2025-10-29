import 'package:genesis/src/features/dbaas/domain/params/databases/database_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';

final class DeleteDatabasesUseCase {
  DeleteDatabasesUseCase(this._repository);

  final IDatabaseRepository _repository;

  Future<void> call(List<DatabaseParams> listOfParams) async {
    await Future.wait(listOfParams.map(_repository.deleteDatabase));
  }
}
