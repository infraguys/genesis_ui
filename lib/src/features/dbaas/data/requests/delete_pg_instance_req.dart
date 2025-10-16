import 'package:genesis/src/core/network/endpoints/pg_instances_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/delete_pg_instance_params.dart';

extension DeletePgInstanceExt on DeletePgInstanceParams {
  String toPath() => PgInstancesEndpoints.deleteInstance(id);
}
