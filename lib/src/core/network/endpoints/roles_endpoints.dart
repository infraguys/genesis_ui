import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';

abstract class RolesEndpoints {
  static Endpoint items() {
    return Endpoint.withCorePrefix('/iam/roles/');
  }

  static Endpoint item(RoleUUID id) {
    return Endpoint.withCorePrefix('/iam/roles/$id');
  }
}
