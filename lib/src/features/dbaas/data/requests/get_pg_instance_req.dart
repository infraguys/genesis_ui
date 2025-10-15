import 'package:genesis/src/core/network/endpoints/pg_instances_endpoints.dart';
import 'package:genesis/src/features/dbaas/domain/params/get_pg_instance_params.dart';

extension GetPgInstanceReqExt on GetPgInstanceParams {
  String toPath() => PgInstancesEndpoints.getInstance(id);
}
