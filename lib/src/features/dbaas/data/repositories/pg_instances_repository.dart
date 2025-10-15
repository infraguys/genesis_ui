import 'package:genesis/src/features/dbaas/data/source/remote/pg_instances_api.dart';
import 'package:genesis/src/features/dbaas/domain/params/get_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';

final class PgInstancesRepository implements IPgInstancesRepository {
  PgInstancesRepository(this._pgInstancesApi);

  final PgInstancesApi _pgInstancesApi;

  @override
  Future<void> deletePgInstance(PgInstanceID uuid) {
    // TODO: implement deletePgInstance
    throw UnimplementedError();
  }

  @override
  Future<PgInstance> getPgInstance(GetPgInstanceParams params) async {
    final dto = await _pgInstancesApi.getPgInstance(params);
    return dto.toEntity();
  }

  @override
  Future<List<PgInstance>> getPgInstances(params) async {
    final dtos = await _pgInstancesApi.getPgInstances(params);
    return dtos.map((it) => it.toEntity()).toList();
  }

  @override
  Future<PgInstance> createPgInstance(params) async {
    final dto = await _pgInstancesApi.createPgInstance(params);
    return dto.toEntity();
  }

  @override
  Future<PgInstance> updatePgInstance(params) async {
    final dto = await _pgInstancesApi.updatePgInstance(params);
    return dto.toEntity();
  }
}
