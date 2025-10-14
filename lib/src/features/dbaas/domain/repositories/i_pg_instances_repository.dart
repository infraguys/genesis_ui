import 'package:genesis/src/features/dbaas/domain/params/create_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/update_pg_instance_params.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';
import 'package:genesis/src/layer_domain/params/dbaas/pg_instances_params/get_pg_instances_params.dart';

abstract interface class IPgInstancesRepository {
  Future<List<PgInstance>> getPgInstances(GetPgInstancesParams params);

  Future<PgInstance> getPgInstance(PgInstanceID uuid);

  Future<PgInstance> createPgInstance(CreatePgInstanceParams params);

  Future<PgInstance> updatePgInstance(UpdatePgInstanceParams params);

  Future<void> deletePgInstance(PgInstanceID uuid);
}
