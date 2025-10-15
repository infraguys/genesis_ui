import 'package:genesis/src/features/dbaas/domain/params/get_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:genesis/src/layer_domain/params/dbaas/pg_instances_params/get_pg_instances_params.dart';

final class GetPgInstanceUseCase {
  GetPgInstanceUseCase(this._repository);

  final IPgInstancesRepository _repository;

  Future<PgInstance> call(PgInstanceID id) {
    return _repository.getPgInstance(GetPgInstanceParams(id));
  }
}
