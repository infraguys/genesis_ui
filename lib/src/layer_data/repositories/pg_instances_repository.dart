import 'package:genesis/src/layer_data/requests/pg_instances_requests/get_pg_instances_req.dart';
import 'package:genesis/src/layer_data/source/remote/pg_intstances_api/pg_instances_api.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:genesis/src/layer_domain/params/dbaas/pg_instances_params/get_pg_instances_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_pg_instances.dart';

final class PGInstancesRepository implements IPGInstancesRepository {
  PGInstancesRepository(this._pgInstancesApi);

  final PgInstancesApi _pgInstancesApi;

  @override
  Future<void> deletePgInstance(PGInstanceUUID uuid) {
    // TODO: implement deletePgInstance
    throw UnimplementedError();
  }

  @override
  Future<PgInstance> getPgInstance(PgInstance uuid) {
    // TODO: implement getPgInstance
    throw UnimplementedError();
  }

  @override
  Future<List<PgInstance>> getPgInstances(GetPgInstancesParams params) async {
    final dtos = await _pgInstancesApi.getPgInstances(GetPgInstancesReq(params));
    return dtos.map((it) => it.toEntity()).toList();
  }
}
