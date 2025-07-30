import 'package:genesis/src/features/permissions/data/dtos/permission_dto.dart';
import 'package:genesis/src/features/permissions/data/requests/get_permission_req.dart';

abstract interface class IPermissionsApi {
  Future<List<PermissionDto>> getPermissions(GetPermissionsReq req);

  Future<PermissionDto> getPermission();

  Future<PermissionDto> createPermission();
}
