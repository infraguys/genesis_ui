import 'package:genesis/src/features/dbaas/domain/entities/pg_instance.dart';
import 'package:genesis/src/features/dbaas/domain/params/create_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/delete_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/get_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/get_pg_instances_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/update_pg_instance_params.dart';

abstract interface class IPgInstancesRepository {
  Future<List<PgInstance>> getPgInstances(GetPgInstancesParams params);

  Future<PgInstance> getPgInstance(GetPgInstanceParams params);

  Future<PgInstance> createPgInstance(CreatePgInstanceParams params);

  Future<PgInstance> updatePgInstance(UpdatePgInstanceParams params);

  Future<void> deletePgInstance(DeletePgInstanceParams params);
}
