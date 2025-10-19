import 'package:genesis/src/features/dbaas/data/requests/create_pg_instance_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/delete_pg_instance_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/get_pg_instance_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/get_pg_instances_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/update_pg_instance_req.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/pg_instances_api.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';

final class PgInstancesRepository implements IPgInstancesRepository {
  PgInstancesRepository(this._pgInstancesApi);

  final PgInstancesApi _pgInstancesApi;

  @override
  Future<void> deletePgInstance(id) async {
    _pgInstancesApi.deletePgInstance(DeletePgInstanceReq(id));
  }

  @override
  Future<PgInstance> getPgInstance(id) async {
    final dto = await _pgInstancesApi.getPgInstance(GetPgInstanceReq(id));
    return dto.toEntity();
  }

  @override
  Future<List<PgInstance>> getPgInstances(params) async {
    final dtos = await _pgInstancesApi.getPgInstances(GetPgInstancesReq(params));
    return dtos.map((it) => it.toEntity()).toList();
  }

  @override
  Future<PgInstance> createPgInstance(params) async {
    final dto = await _pgInstancesApi.createPgInstance(CreatePgInstanceReq(params));
    return dto.toEntity();
  }

  @override
  Future<PgInstance> updatePgInstance(params) async {
    final dto = await _pgInstancesApi.updatePgInstance(UpdatePgInstanceReq(params));
    return dto.toEntity();
  }
}
