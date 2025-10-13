import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:genesis/src/layer_domain/params/dbaas/pg_instances_params/get_pg_instances_params.dart';

abstract interface class IPgInstancesRepository {
  Future<PgInstance> getPgInstance(PgInstance uuid);

  Future<List<PgInstance>> getPgInstances(GetPgInstancesParams params);

  // Future<PGInstance> createNode(CreateNodeParams params);

  // Future<PGInstance> updateNode(UpdateNodeParams params);

  Future<void> deletePgInstance(PgInstanceUUID uuid);
}