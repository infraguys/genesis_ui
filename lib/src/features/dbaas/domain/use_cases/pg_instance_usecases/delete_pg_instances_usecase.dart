import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';

final class DeletePgInstancesUseCase {
  DeletePgInstancesUseCase(this._repository);

  final IPgInstancesRepository _repository;

  Future<void> call(List<PgInstanceID> ids) async {
    await Future.wait(
      ids.map(_repository.deletePgInstance),
    );
  }
}
