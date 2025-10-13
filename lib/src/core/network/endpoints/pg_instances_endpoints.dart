import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';

abstract class PGInstancesEndpoints {
  static const _instances = '${Env.dbaasApiPrefix}/${Env.versionApi}/types/postgres/instances/';
  static const _instance = '$_instances:uuid';

  static String getInstances() => _instances;

  static String createInstance() => _instances;

  static String getInstance(PgInstanceUUID uuid) => _instance.fillUuid(uuid);

  static String updateInstance(PgInstanceUUID uuid) => _instance.fillUuid(uuid);

  static String deleteInstance(PgInstanceUUID uuid) => _instance.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(PgInstanceUUID uuid) => replaceFirst(':uuid', uuid.raw);
}
