import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';

abstract class PgInstancesEndpoints {
  static const _instances = '${Env.dbaasApiPrefix}/${Env.versionApi}/types/postgres/instances/';
  static const _instance = '$_instances:id';

  static String getInstances() => _instances;

  static String createInstance() => _instances;

  static String getInstance(PgInstanceID id) => _instance.fillUuid(id);

  static String updateInstance(PgInstanceID id) => _instance.fillUuid(id);

  static String deleteInstance(PgInstanceID id) => _instance.fillUuid(id);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(PgInstanceID uuid) => replaceFirst('id', uuid.raw);
}
