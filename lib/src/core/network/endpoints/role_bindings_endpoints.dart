import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/roles/domain/entities/role_binding.dart';

abstract class RoleBindingsEndpoints {
  static Endpoint items() {
    return Endpoint.withCorePrefix('/iam/role_bindings/');
  }

  static Endpoint item(RoleBindingUUID id) {
    return Endpoint.withCorePrefix('/iam/role_bindings/$id');
  }
}
