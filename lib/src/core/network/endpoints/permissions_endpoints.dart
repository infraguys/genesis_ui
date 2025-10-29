import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission.dart';

abstract class PermissionsEndpoints {
  static Endpoint items() {
    return Endpoint.withCorePrefix('/iam/permissions/');
  }

  static Endpoint item(PermissionID id) {
    return Endpoint.withCorePrefix('/iam/permissions/$id');
  }
}
