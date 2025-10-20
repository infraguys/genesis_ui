import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission_binding.dart';

abstract class PermissionBindingsEndpoints {
  static Endpoint items() {
    return Endpoint.withCorePrefix('/iam/permission_bindings/');
  }

  static Endpoint item(PermissionBindingID id) {
    return Endpoint.withCorePrefix('/iam/permission_bindings/$id');
  }
}
