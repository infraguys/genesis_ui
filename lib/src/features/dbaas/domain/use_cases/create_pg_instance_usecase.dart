import 'package:genesis/src/features/dbaas/domain/params/create_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';

final class CreatePgInstanceUseCase {
  CreatePgInstanceUseCase(this._repository);

  final IPgInstancesRepository _repository;

  Future<PgInstance> call(CreatePgInstanceParams params) {
    return _repository.createPgInstance(params);
  }
}
