import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';

final class DeletePgInstanceUseCase {
  DeletePgInstanceUseCase(this._repository);

  final IPgInstancesRepository _repository;

  Future<void> call(PgInstanceID id) async {
    await _repository.deletePgInstance(id);
  }
}
