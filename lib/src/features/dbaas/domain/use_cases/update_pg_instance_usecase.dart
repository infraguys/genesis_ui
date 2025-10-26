import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/params/pg_instances/update_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';

final class UpdatePgInstanceUseCase {
  UpdatePgInstanceUseCase(this._repository);

  final IPgInstancesRepository _repository;

  Future<PgInstance> call(UpdatePgInstanceParams params) async {
    return await _repository.updatePgInstance(params);
  }
}
