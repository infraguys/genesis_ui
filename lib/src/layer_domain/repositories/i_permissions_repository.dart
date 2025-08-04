import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:genesis/src/layer_domain/params/get_permissions_params.dart';

abstract interface class IPermissionsRepository {
  Future<List<Permission>> getPermissions(GetPermissionsParams params);

  Future<Permission> getPermission();

  Future<Permission> createPermission();
}
