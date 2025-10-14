import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:genesis/src/layer_domain/params/dbaas/pg_instances_params/get_pg_instances_params.dart';

final class GetPgInstancesUseCase {
  GetPgInstancesUseCase(this._repository);

  final IPgInstancesRepository _repository;

  Future<List<PgInstance>> call(GetPgInstancesParams params) {
    return _repository.getPgInstances(params);
  }
}
