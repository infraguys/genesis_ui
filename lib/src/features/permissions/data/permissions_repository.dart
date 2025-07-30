import 'package:genesis/src/features/common/shared_entities/permission.dart';
import 'package:genesis/src/features/permissions/data/requests/get_permission_req.dart';
import 'package:genesis/src/features/permissions/data/source/i_permissions_api.dart';
import 'package:genesis/src/features/permissions/domain/i_permissions_repository.dart';
import 'package:genesis/src/features/permissions/domain/params/get_permissions_params.dart';

final class PermissionsRepository implements IPermissionsRepository {
  const PermissionsRepository(this._permissionsApi);

  final IPermissionsApi _permissionsApi;

  @override
  Future<Permission> createPermission() {
    // TODO: implement createPermission
    throw UnimplementedError();
  }

  @override
  Future<Permission> getPermission() {
    // TODO: implement getPermission
    throw UnimplementedError();
  }

  @override
  Future<List<Permission>> getPermissions(GetPermissionsParams params) async {
    final req = GetPermissionsReq(params);
    final dtoList = await _permissionsApi.getPermissions(req);
    return dtoList.map((dto) => dto.toEntity()).toList();
  }
}
